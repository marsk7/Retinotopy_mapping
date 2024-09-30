# Retinotopy_mapping
`import lmod`

`await lmod.load('deepretinotopy/1.0.5')`

`deepRetinotopy -s $path_freesurfer_dir -t $path_hcp_template_surfaces -d $dataset_name -m $maps`

The following arguments mean:

-s path to the freesurfer directory
-t path to the HCP "fs_LR-deformed_to-fsaverage" surfaces
-d dataset name (e.g. "HCP")
-m maps to be generated (e.g. "polarAngle,eccentricity,pRFsize")

### e.g.
`!deepRetinotopy -s /neurodesktop-storage/nyu_retinotopy_data/freesurfer/sub-wlsubj001/surf \
                -t /neurodesktop-storage/HCPpipelines-master/global/templates/standard_mesh_atlases/resample_fsaverage/fs_LR-deformed_to-fsaverage.L.sphere.32k_fs_LR.surf.gii \
                -d "HCP" \
                -m "leftHemisphere"`
