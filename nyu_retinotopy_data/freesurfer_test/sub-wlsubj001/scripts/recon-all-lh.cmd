

#---------------------------------
# New invocation of recon-all Mon Apr  6 20:54:30 EDT 2020 
#--------------------------------------------
#@# Tessellate lh Mon Apr  6 20:54:31 EDT 2020

 mri_pretess ../mri/filled.mgz 255 ../mri/norm.mgz ../mri/filled-pretess255.mgz 


 mri_tessellate ../mri/filled-pretess255.mgz 255 ../surf/lh.orig.nofix 


 rm -f ../mri/filled-pretess255.mgz 


 mris_extract_main_component ../surf/lh.orig.nofix ../surf/lh.orig.nofix 

#--------------------------------------------
#@# Smooth1 lh Mon Apr  6 20:54:38 EDT 2020

 mris_smooth -nw -seed 1234 ../surf/lh.orig.nofix ../surf/lh.smoothwm.nofix 

#--------------------------------------------
#@# Inflation1 lh Mon Apr  6 20:54:44 EDT 2020

 mris_inflate -no-save-sulc -n 50 ../surf/lh.smoothwm.nofix ../surf/lh.inflated.nofix 

#--------------------------------------------
#@# QSphere lh Mon Apr  6 20:57:24 EDT 2020

 mris_sphere -q -seed 1234 ../surf/lh.inflated.nofix ../surf/lh.qsphere.nofix 

#--------------------------------------------
#@# Fix Topology Copy lh Mon Apr  6 21:00:33 EDT 2020

 cp ../surf/lh.orig.nofix ../surf/lh.orig 


 cp ../surf/lh.inflated.nofix ../surf/lh.inflated 

#@# Fix Topology lh Mon Apr  6 21:00:33 EDT 2020

 mris_fix_topology -rusage /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/touch/rusage.mris_fix_topology.lh.dat -mgz -sphere qsphere.nofix -ga -seed 1234 sub-wlsubj001 lh 


 mris_euler_number ../surf/lh.orig 


 mris_remove_intersection ../surf/lh.orig ../surf/lh.orig 


 rm ../surf/lh.inflated 

#--------------------------------------------
#@# Make White Surf lh Mon Apr  6 21:15:55 EDT 2020

 mris_make_surfaces -aseg ../mri/aseg.presurf -white white.preaparc -noaparc -whiteonly -mgz -T1 brain.finalsurfs sub-wlsubj001 lh 

#--------------------------------------------
#@# Smooth2 lh Mon Apr  6 21:20:54 EDT 2020

 mris_smooth -n 3 -nw -seed 1234 ../surf/lh.white.preaparc ../surf/lh.smoothwm 

#--------------------------------------------
#@# Inflation2 lh Mon Apr  6 21:21:01 EDT 2020

 mris_inflate -rusage /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/touch/rusage.mris_inflate.lh.dat -n 50 ../surf/lh.smoothwm ../surf/lh.inflated 

#--------------------------------------------
#@# Curv .H and .K lh Mon Apr  6 21:22:17 EDT 2020

 mris_curvature -w lh.white.preaparc 


 mris_curvature -thresh .999 -n -a 5 -w -distances 10 10 lh.inflated 


#-----------------------------------------
#@# Curvature Stats lh Mon Apr  6 21:23:43 EDT 2020

 mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/lh.curv.stats -F smoothwm sub-wlsubj001 lh curv sulc 

#--------------------------------------------
#@# Sphere lh Mon Apr  6 21:23:48 EDT 2020

 mris_sphere -rusage /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/touch/rusage.mris_sphere.lh.dat -seed 1234 ../surf/lh.inflated ../surf/lh.sphere 

#--------------------------------------------
#@# Surf Reg lh Mon Apr  6 21:41:47 EDT 2020

 mris_register -curv -rusage /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/touch/rusage.mris_register.lh.dat ../surf/lh.sphere /opt/freesurfer/average/lh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif ../surf/lh.sphere.reg 

#--------------------------------------------
#@# Jacobian white lh Mon Apr  6 22:41:19 EDT 2020

 mris_jacobian ../surf/lh.white.preaparc ../surf/lh.sphere.reg ../surf/lh.jacobian_white 

#--------------------------------------------
#@# AvgCurv lh Mon Apr  6 22:41:22 EDT 2020

 mrisp_paint -a 5 /opt/freesurfer/average/lh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif#6 ../surf/lh.sphere.reg ../surf/lh.avg_curv 

#-----------------------------------------
#@# Cortical Parc lh Mon Apr  6 22:41:24 EDT 2020

 mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-wlsubj001 lh ../surf/lh.sphere.reg /opt/freesurfer/average/lh.DKaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.annot 

#--------------------------------------------
#@# Make Pial Surf lh Mon Apr  6 22:41:42 EDT 2020

 mris_make_surfaces -orig_white white.preaparc -orig_pial white.preaparc -aseg ../mri/aseg.presurf -mgz -T1 brain.finalsurfs sub-wlsubj001 lh 

#--------------------------------------------
#@# Surf Volume lh Mon Apr  6 22:58:02 EDT 2020
#-----------------------------------------
#@# Cortical Parc 2 lh Mon Apr  6 22:58:06 EDT 2020

 mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-wlsubj001 lh ../surf/lh.sphere.reg /opt/freesurfer/average/lh.CDaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.a2009s.annot 

#-----------------------------------------
#@# Cortical Parc 3 lh Mon Apr  6 22:58:27 EDT 2020

 mris_ca_label -l ../label/lh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-wlsubj001 lh ../surf/lh.sphere.reg /opt/freesurfer/average/lh.DKTaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/lh.aparc.DKTatlas.annot 

#-----------------------------------------
#@# WM/GM Contrast lh Mon Apr  6 22:58:42 EDT 2020

 pctsurfcon --s sub-wlsubj001 --lh-only 



#---------------------------------
# New invocation of recon-all Mon Apr  6 23:22:47 EDT 2020 
#-----------------------------------------
#@# Parcellation Stats lh Mon Apr  6 23:22:48 EDT 2020

 mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.stats -b -a ../label/lh.aparc.annot -c ../label/aparc.annot.ctab sub-wlsubj001 lh white 


 mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.pial.stats -b -a ../label/lh.aparc.annot -c ../label/aparc.annot.ctab sub-wlsubj001 lh pial 

#-----------------------------------------
#@# Parcellation Stats 2 lh Mon Apr  6 23:24:35 EDT 2020

 mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.a2009s.stats -b -a ../label/lh.aparc.a2009s.annot -c ../label/aparc.annot.a2009s.ctab sub-wlsubj001 lh white 

#-----------------------------------------
#@# Parcellation Stats 3 lh Mon Apr  6 23:25:26 EDT 2020

 mris_anatomical_stats -th3 -mgz -cortex ../label/lh.cortex.label -f ../stats/lh.aparc.DKTatlas.stats -b -a ../label/lh.aparc.DKTatlas.annot -c ../label/aparc.annot.DKTatlas.ctab sub-wlsubj001 lh white 

#--------------------------------------------
#@# BA_exvivo Labels lh Mon Apr  6 23:26:20 EDT 2020

 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.BA1_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./lh.BA1_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.BA2_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./lh.BA2_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.BA3a_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./lh.BA3a_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.BA3b_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./lh.BA3b_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.BA4a_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./lh.BA4a_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.BA4p_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./lh.BA4p_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.BA6_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./lh.BA6_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.BA44_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./lh.BA44_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.BA45_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./lh.BA45_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.V1_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./lh.V1_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.V2_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./lh.V2_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.MT_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./lh.MT_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.entorhinal_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./lh.entorhinal_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.perirhinal_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./lh.perirhinal_exvivo.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.BA1_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./lh.BA1_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.BA2_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./lh.BA2_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.BA3a_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./lh.BA3a_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.BA3b_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./lh.BA3b_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.BA4a_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./lh.BA4a_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.BA4p_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./lh.BA4p_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.BA6_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./lh.BA6_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.BA44_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./lh.BA44_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.BA45_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./lh.BA45_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.V1_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./lh.V1_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.V2_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./lh.V2_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.MT_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./lh.MT_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.entorhinal_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./lh.entorhinal_exvivo.thresh.label --hemi lh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/lh.perirhinal_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./lh.perirhinal_exvivo.thresh.label --hemi lh --regmethod surface 


 mris_label2annot --s sub-wlsubj001 --hemi lh --ctab /opt/freesurfer/average/colortable_BA.txt --l lh.BA1_exvivo.label --l lh.BA2_exvivo.label --l lh.BA3a_exvivo.label --l lh.BA3b_exvivo.label --l lh.BA4a_exvivo.label --l lh.BA4p_exvivo.label --l lh.BA6_exvivo.label --l lh.BA44_exvivo.label --l lh.BA45_exvivo.label --l lh.V1_exvivo.label --l lh.V2_exvivo.label --l lh.MT_exvivo.label --l lh.entorhinal_exvivo.label --l lh.perirhinal_exvivo.label --a BA_exvivo --maxstatwinner --noverbose 


 mris_label2annot --s sub-wlsubj001 --hemi lh --ctab /opt/freesurfer/average/colortable_BA.txt --l lh.BA1_exvivo.thresh.label --l lh.BA2_exvivo.thresh.label --l lh.BA3a_exvivo.thresh.label --l lh.BA3b_exvivo.thresh.label --l lh.BA4a_exvivo.thresh.label --l lh.BA4p_exvivo.thresh.label --l lh.BA6_exvivo.thresh.label --l lh.BA44_exvivo.thresh.label --l lh.BA45_exvivo.thresh.label --l lh.V1_exvivo.thresh.label --l lh.V2_exvivo.thresh.label --l lh.MT_exvivo.thresh.label --l lh.entorhinal_exvivo.thresh.label --l lh.perirhinal_exvivo.thresh.label --a BA_exvivo.thresh --maxstatwinner --noverbose 


 mris_anatomical_stats -th3 -mgz -f ../stats/lh.BA_exvivo.stats -b -a ./lh.BA_exvivo.annot -c ./BA_exvivo.ctab sub-wlsubj001 lh white 


 mris_anatomical_stats -th3 -mgz -f ../stats/lh.BA_exvivo.thresh.stats -b -a ./lh.BA_exvivo.thresh.annot -c ./BA_exvivo.thresh.ctab sub-wlsubj001 lh white 

