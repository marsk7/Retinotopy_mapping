import numpy as np
import scipy.io
import os.path as osp
import sys
import nibabel as nib
import matplotlib.pyplot as plt
import nilearn
import warnings
from nilearn import plotting
from matplotlib.colors import ListedColormap

warnings.filterwarnings("ignore", category=DeprecationWarning) 
warnings.filterwarnings("ignore", category=UserWarning) 

def roi(list_of_labels):
    """Mask for the selection of the region of interest in the surface
    template.

    Args:
        list_of_labels (list): list with the file name (.mat) containing the
            region of interest (from both L and R hemispheres)

    Returns:
        final_mask_L (numpy array): Mask of the region of interest from left
            hemisphere (32492,)

        final_mask_R (numpy array): Mask of the region of interest from
            right hemisphere (32492,)

        index_L_mask (list): Indices of the non-zero elements from
            final_mask_L (number of nonzero elements,)

        index_R_mask (list): Indices of the non-zero elements from
            final_mask_R (number of nonzero elements,)

    """

    # Defining number of nodes
    number_cortical_nodes = int(64984)
    number_hemi_nodes = int(number_cortical_nodes / 2)

    list_primary_visual_areas = np.zeros([len(list_of_labels), 64984])
    for i in range(len(list_of_labels)):
        list_primary_visual_areas[i] = np.reshape(scipy.io.loadmat(
            osp.join('/cvmfs/neurodesk.ardc.edu.au/containers/deepretinotopy_1.0.2_20231223/deepretinotopy_1.0.2_20231223.simg/opt/deepRetinotopy_TheToolbox/labels/',
                     'ROI_WangPlusFovea/',
                     list_of_labels[i] + '.mat'))[list_of_labels[i]][0:64984],
                                                  (-1))

    final_mask_L = np.sum(list_primary_visual_areas, axis=0)[
                   0:number_hemi_nodes]
    final_mask_R = np.sum(list_primary_visual_areas, axis=0)[
                   number_hemi_nodes:number_cortical_nodes]

    index_L_mask = [i for i, j in enumerate(final_mask_L) if j == 1]
    index_R_mask = [i for i, j in enumerate(final_mask_R) if j == 1]

    return final_mask_L, final_mask_R, index_L_mask, index_R_mask


def polarAngle_plot(subject_id, path, surface, template_path, prediction = 'average', binarize=False, save=False, save_path=None):
    """
    Plot the polar angle map of the early visual cortex.
    Parameters
    ----------
    subject_id : int
        Subject ID.
    path : str  
        Path to the data.
    template_path : str  
        Path to template surfaces.
    predictions : str
        Prediction (model 1 to 5 or average) or empirical
    binarize : bool, optional
        Binarize the polar angle map. The default is False.
    save : bool, optional
        Save the figure. The default is False.
    save_path : str, optional
        Path to save the figure. The default is None.
    Returns
    ------- 
    view : nilearn.plotting.view_img
    """
    # Number of nodes
    number_cortical_nodes = int(64984)
    number_hemi_nodes = int(number_cortical_nodes / 2)

    # Loading the curvature map
    # background = np.array(nib.load(osp.join(path,
    #                              subject_id + '/surf/' + subject_id + '.curvature-midthickness.lh.32k_fs_LR.func.gii')).agg_data()).reshape(
    #                              number_hemi_nodes, -1)
    background = np.array(nib.load(path + '_' + surface +  '/' + 
                                 subject_id + 
                                   # '/surf/fs_empirical.lh.32k_fs_LR.func.gii'
                                 '/surf/'+ subject_id +'.curvature-midthickness.lh.32k_fs_LR.func.gii').agg_data()).reshape(
                                 number_hemi_nodes, -1)

    # Background settings
    threshold = 1  # threshold for the curvature map
    nocurv = np.isnan(background)
    background[nocurv == 1] = 0
    background[background < 0] = 0
    background[background > 0] = 1

    # visual cortex
    label_primary_visual_areas = ['ROI']
    final_mask_L, final_mask_R, index_L_mask, index_R_mask = roi(
        label_primary_visual_areas)

    # Loading the polarAngle predictions
    polarAngle = np.zeros((32492, 1))
    # polarAngle = []
    if prediction != 'empirical':
        data = np.array(nib.load(path +  '_' + surface + '/' + 
                                     subject_id + '/deepRetinotopy/' + subject_id + '.fs_predicted_polarAngle_lh_curvatureFeat_' + prediction + '.func.gii').agg_data()).reshape(
                                     number_hemi_nodes, -1)
        # .reshape(number_hemi_nodes, -1)
        # polarAngle[final_mask_L == 1] = np
        polarAngle[final_mask_L == 1] = np.reshape(
            data[final_mask_L == 1], (-1, 1))

        # Reshift values
        subtract = polarAngle >= 180
        add = polarAngle < 180
        polarAngle[subtract] = polarAngle[subtract] - 180
        polarAngle[add] = polarAngle[add] + 180
    
    else:
        # data = np.array(nib.load(osp.join(path,
        #                              '../freesurfer_test/' + subject_id + '/deepRetinotopy/' + subject_id + '.fs_empirical_polarAngle_lh.func.gii')).agg_data())
        data = np.array(nib.load(path +  '_' + surface +  '/' + 
                                     subject_id + '/surf/fs_empirical.lh.32k_fs_LR.func.gii').agg_data()).reshape(
                                     number_hemi_nodes, -1)
        # polarAngle = np.reshape(data,(-1))
        # polarAngle = np.reshape(data, (-1, 1))
        polarAngle[final_mask_L == 1] = np.reshape(
            data[final_mask_L == 1], (-1, 1))
        
         # Reshift values
        subtract = polarAngle >= 180
        add = polarAngle < 180
        polarAngle[subtract] = polarAngle[subtract] - 180
        polarAngle[add] = polarAngle[add] + 180

    # Masking
    polarAngle = np.array(polarAngle) + threshold

    polarAngle[final_mask_L != 1] = 0

    # Binarizing values
    if binarize == True:
        polarAngle[(polarAngle >= 0) & (polarAngle <= 45)] = 0 + threshold
        polarAngle[(polarAngle > 45) & (polarAngle <= 180)] = 90 + threshold
        polarAngle[(polarAngle >= 315) & (polarAngle <= 360)] = 360 + threshold
        polarAngle[(polarAngle > 180) & (polarAngle < 315)] = 270 + threshold

        polarAngle[final_mask_L != 1] = 0

    # Plotting
    view = plotting.view_surf(
        surf_mesh=osp.join(template_path,'fs_LR-deformed_to-fsaverage.L.sphere.32k_fs_LR.surf.gii'),
        surf_map=np.reshape(polarAngle[0:32492], (-1)), bg_map=background,
        cmap='gist_rainbow_r', black_bg=False, symmetric_cmap=False,
        threshold=threshold, vmax=361)
    
    # view.open_in_browser()
    if save == True:
        view.save_as_html(
            osp.join(save_path, 'polarAngle_' + subject_id + '.html'))
    return view


def signMap_plot(subject_id, path, template_path, hemisphere = 'lh'):
    """
    Plot the polar angle map of the early visual cortex.
    Parameters
    ----------
    subject_id : int
        Subject ID.
    path : str  
        Path to the data.
    template_path : str  
        Path to template surfaces.
    hemisphere : str
        'lh' or 'rh'
    Returns
    ------- 
    view : nilearn.plotting.view_img
    """
    # Number of nodes
    number_cortical_nodes = int(64984)
    number_hemi_nodes = int(number_cortical_nodes / 2)

    # visual cortex
    label_primary_visual_areas = ['ROI']
    final_mask_L, final_mask_R, index_L_mask, index_R_mask = roi(
        label_primary_visual_areas)
    
    # Loading the curvature map
    if hemisphere == 'lh':
        background = np.array(nib.load(osp.join(path,
                                     subject_id + '/surf/' + subject_id + '.curvature-midthickness.lh.32k_fs_LR.func.gii')).agg_data()).reshape(
                                     number_hemi_nodes, -1)
        # Background settings
        threshold = 1  # threshold for the curvature map
        nocurv = np.isnan(background)
        background[nocurv == 1] = 0
        background[background < 0] = 0
        background[background > 0] = 1
        
        # Loading the sign map
        signMap = np.zeros((32492, 1))
        data = np.array(nib.load(osp.join(path,
                                     subject_id + '/deepRetinotopy/' + subject_id + '.fieldSignMap_lh.func.gii')).agg_data()).reshape(
                                     number_hemi_nodes, -1) #sign maps are either -1 or 1
        signMap[final_mask_L == 1] = np.reshape(
                data[final_mask_L == 1], (-1, 1))
    
        # Masking
        # signMap[signMap==-1] = 0
        # signMap = np.array(signMap) + threshold
        # signMap[final_mask_L != 1] = 0
    
        # Plotting
        cmap = plt.cm.get_cmap('viridis', 100)
        newcolors = cmap(np.linspace(0, 1, 100))
        newcolors = [newcolors[50], newcolors[99], newcolors[0]]
        newcolors = ListedColormap(newcolors)

        view = plotting.view_surf(
            surf_mesh=osp.join(template_path,'fs_LR-deformed_to-fsaverage.L.sphere.32k_fs_LR.surf.gii'),
            surf_map=np.reshape(signMap[0:32492], (-1)), bg_map=background,
            cmap=newcolors, black_bg=False, symmetric_cmap=False,
            threshold=threshold, vmax=2)
        
    else:
        background = np.array(nib.load(osp.join(path,
                                     subject_id + '/surf/' + subject_id + '.curvature-midthickness.rh.32k_fs_LR.func.gii')).agg_data()).reshape(
                                     number_hemi_nodes, -1)

        # Background settings
        threshold = 1  # threshold for the curvature map
        nocurv = np.isnan(background)
        background[nocurv == 1] = 0
        background[background < 0] = 0
        background[background > 0] = 1

        # Loading the sign map
        signMap = np.zeros((32492, 1))
        data = np.array(nib.load(osp.join(path,
                                     subject_id + '/deepRetinotopy/' + subject_id + '.fieldSignMap_rh.func.gii')).agg_data()).reshape(
                                     number_hemi_nodes, -1) #sign maps are either -1 or 1
        signMap[final_mask_R == 1] = np.reshape(
                data[final_mask_R == 1], (-1, 1))
    
        # Masking
        signMap[signMap==-1] = 0
        signMap = np.array(signMap) + threshold
        signMap[final_mask_R != 1] = 0
    
        # Plotting
        cmap = plt.cm.get_cmap('viridis', 100)
        newcolors = cmap(np.linspace(0, 1, 100))
        newcolors = [newcolors[50], newcolors[99], newcolors[0]]
        newcolors = ListedColormap(newcolors)

        view = plotting.view_surf(
            surf_mesh=osp.join(template_path,'fs_LR-deformed_to-fsaverage.R.sphere.32k_fs_LR.surf.gii'),
            surf_map=np.reshape(signMap[0:32492], (-1)), bg_map=background,
            cmap=newcolors, black_bg=False, symmetric_cmap=False,
            threshold=threshold, vmax=2)
    return view