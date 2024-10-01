

#---------------------------------
# New invocation of recon-all Mon Apr  6 20:54:30 EDT 2020 
#--------------------------------------------
#@# Tessellate rh Mon Apr  6 20:54:31 EDT 2020

 mri_pretess ../mri/filled.mgz 127 ../mri/norm.mgz ../mri/filled-pretess127.mgz 


 mri_tessellate ../mri/filled-pretess127.mgz 127 ../surf/rh.orig.nofix 


 rm -f ../mri/filled-pretess127.mgz 


 mris_extract_main_component ../surf/rh.orig.nofix ../surf/rh.orig.nofix 

#--------------------------------------------
#@# Smooth1 rh Mon Apr  6 20:54:42 EDT 2020

 mris_smooth -nw -seed 1234 ../surf/rh.orig.nofix ../surf/rh.smoothwm.nofix 

#--------------------------------------------
#@# Inflation1 rh Mon Apr  6 20:54:50 EDT 2020

 mris_inflate -no-save-sulc -n 50 ../surf/rh.smoothwm.nofix ../surf/rh.inflated.nofix 

#--------------------------------------------
#@# QSphere rh Mon Apr  6 20:57:28 EDT 2020

 mris_sphere -q -seed 1234 ../surf/rh.inflated.nofix ../surf/rh.qsphere.nofix 

#--------------------------------------------
#@# Fix Topology Copy rh Mon Apr  6 21:00:44 EDT 2020

 cp ../surf/rh.orig.nofix ../surf/rh.orig 


 cp ../surf/rh.inflated.nofix ../surf/rh.inflated 

#@# Fix Topology rh Mon Apr  6 21:00:44 EDT 2020

 mris_fix_topology -rusage /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/touch/rusage.mris_fix_topology.rh.dat -mgz -sphere qsphere.nofix -ga -seed 1234 sub-wlsubj001 rh 


 mris_euler_number ../surf/rh.orig 


 mris_remove_intersection ../surf/rh.orig ../surf/rh.orig 


 rm ../surf/rh.inflated 

#--------------------------------------------
#@# Make White Surf rh Mon Apr  6 21:16:58 EDT 2020

 mris_make_surfaces -aseg ../mri/aseg.presurf -white white.preaparc -noaparc -whiteonly -mgz -T1 brain.finalsurfs sub-wlsubj001 rh 

#--------------------------------------------
#@# Smooth2 rh Mon Apr  6 21:21:59 EDT 2020

 mris_smooth -n 3 -nw -seed 1234 ../surf/rh.white.preaparc ../surf/rh.smoothwm 

#--------------------------------------------
#@# Inflation2 rh Mon Apr  6 21:22:06 EDT 2020

 mris_inflate -rusage /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/touch/rusage.mris_inflate.rh.dat -n 50 ../surf/rh.smoothwm ../surf/rh.inflated 

#--------------------------------------------
#@# Curv .H and .K rh Mon Apr  6 21:23:26 EDT 2020

 mris_curvature -w rh.white.preaparc 


 mris_curvature -thresh .999 -n -a 5 -w -distances 10 10 rh.inflated 


#-----------------------------------------
#@# Curvature Stats rh Mon Apr  6 21:24:50 EDT 2020

 mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/rh.curv.stats -F smoothwm sub-wlsubj001 rh curv sulc 

#--------------------------------------------
#@# Sphere rh Mon Apr  6 21:24:55 EDT 2020

 mris_sphere -rusage /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/touch/rusage.mris_sphere.rh.dat -seed 1234 ../surf/rh.inflated ../surf/rh.sphere 

#--------------------------------------------
#@# Surf Reg rh Mon Apr  6 21:44:53 EDT 2020

 mris_register -curv -rusage /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/touch/rusage.mris_register.rh.dat ../surf/rh.sphere /opt/freesurfer/average/rh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif ../surf/rh.sphere.reg 

#--------------------------------------------
#@# Jacobian white rh Mon Apr  6 22:50:02 EDT 2020

 mris_jacobian ../surf/rh.white.preaparc ../surf/rh.sphere.reg ../surf/rh.jacobian_white 

#--------------------------------------------
#@# AvgCurv rh Mon Apr  6 22:50:05 EDT 2020

 mrisp_paint -a 5 /opt/freesurfer/average/rh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif#6 ../surf/rh.sphere.reg ../surf/rh.avg_curv 

#-----------------------------------------
#@# Cortical Parc rh Mon Apr  6 22:50:08 EDT 2020

 mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-wlsubj001 rh ../surf/rh.sphere.reg /opt/freesurfer/average/rh.DKaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.annot 

#--------------------------------------------
#@# Make Pial Surf rh Mon Apr  6 22:50:22 EDT 2020

 mris_make_surfaces -orig_white white.preaparc -orig_pial white.preaparc -aseg ../mri/aseg.presurf -mgz -T1 brain.finalsurfs sub-wlsubj001 rh 

#--------------------------------------------
#@# Surf Volume rh Mon Apr  6 23:07:02 EDT 2020
#-----------------------------------------
#@# Cortical Parc 2 rh Mon Apr  6 23:07:06 EDT 2020

 mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-wlsubj001 rh ../surf/rh.sphere.reg /opt/freesurfer/average/rh.CDaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.a2009s.annot 

#-----------------------------------------
#@# Cortical Parc 3 rh Mon Apr  6 23:07:25 EDT 2020

 mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-wlsubj001 rh ../surf/rh.sphere.reg /opt/freesurfer/average/rh.DKTaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.DKTatlas.annot 

#-----------------------------------------
#@# WM/GM Contrast rh Mon Apr  6 23:07:41 EDT 2020

 pctsurfcon --s sub-wlsubj001 --rh-only 



#---------------------------------
# New invocation of recon-all Mon Apr  6 23:22:47 EDT 2020 
#-----------------------------------------
#@# Parcellation Stats rh Mon Apr  6 23:22:48 EDT 2020

 mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.stats -b -a ../label/rh.aparc.annot -c ../label/aparc.annot.ctab sub-wlsubj001 rh white 


 mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.pial.stats -b -a ../label/rh.aparc.annot -c ../label/aparc.annot.ctab sub-wlsubj001 rh pial 

#-----------------------------------------
#@# Parcellation Stats 2 rh Mon Apr  6 23:24:38 EDT 2020

 mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.a2009s.stats -b -a ../label/rh.aparc.a2009s.annot -c ../label/aparc.annot.a2009s.ctab sub-wlsubj001 rh white 

#-----------------------------------------
#@# Parcellation Stats 3 rh Mon Apr  6 23:25:31 EDT 2020

 mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.DKTatlas.stats -b -a ../label/rh.aparc.DKTatlas.annot -c ../label/aparc.annot.DKTatlas.ctab sub-wlsubj001 rh white 

#--------------------------------------------
#@# BA_exvivo Labels rh Mon Apr  6 23:26:26 EDT 2020

 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.BA1_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./rh.BA1_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.BA2_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./rh.BA2_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.BA3a_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./rh.BA3a_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.BA3b_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./rh.BA3b_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.BA4a_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./rh.BA4a_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.BA4p_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./rh.BA4p_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.BA6_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./rh.BA6_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.BA44_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./rh.BA44_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.BA45_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./rh.BA45_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.V1_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./rh.V1_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.V2_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./rh.V2_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.MT_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./rh.MT_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.entorhinal_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./rh.entorhinal_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.perirhinal_exvivo.label --trgsubject sub-wlsubj001 --trglabel ./rh.perirhinal_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.BA1_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./rh.BA1_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.BA2_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./rh.BA2_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.BA3a_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./rh.BA3a_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.BA3b_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./rh.BA3b_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.BA4a_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./rh.BA4a_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.BA4p_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./rh.BA4p_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.BA6_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./rh.BA6_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.BA44_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./rh.BA44_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.BA45_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./rh.BA45_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.V1_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./rh.V1_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.V2_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./rh.V2_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.MT_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./rh.MT_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.entorhinal_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./rh.entorhinal_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/fsaverage/label/rh.perirhinal_exvivo.thresh.label --trgsubject sub-wlsubj001 --trglabel ./rh.perirhinal_exvivo.thresh.label --hemi rh --regmethod surface 


 mris_label2annot --s sub-wlsubj001 --hemi rh --ctab /opt/freesurfer/average/colortable_BA.txt --l rh.BA1_exvivo.label --l rh.BA2_exvivo.label --l rh.BA3a_exvivo.label --l rh.BA3b_exvivo.label --l rh.BA4a_exvivo.label --l rh.BA4p_exvivo.label --l rh.BA6_exvivo.label --l rh.BA44_exvivo.label --l rh.BA45_exvivo.label --l rh.V1_exvivo.label --l rh.V2_exvivo.label --l rh.MT_exvivo.label --l rh.entorhinal_exvivo.label --l rh.perirhinal_exvivo.label --a BA_exvivo --maxstatwinner --noverbose 


 mris_label2annot --s sub-wlsubj001 --hemi rh --ctab /opt/freesurfer/average/colortable_BA.txt --l rh.BA1_exvivo.thresh.label --l rh.BA2_exvivo.thresh.label --l rh.BA3a_exvivo.thresh.label --l rh.BA3b_exvivo.thresh.label --l rh.BA4a_exvivo.thresh.label --l rh.BA4p_exvivo.thresh.label --l rh.BA6_exvivo.thresh.label --l rh.BA44_exvivo.thresh.label --l rh.BA45_exvivo.thresh.label --l rh.V1_exvivo.thresh.label --l rh.V2_exvivo.thresh.label --l rh.MT_exvivo.thresh.label --l rh.entorhinal_exvivo.thresh.label --l rh.perirhinal_exvivo.thresh.label --a BA_exvivo.thresh --maxstatwinner --noverbose 


 mris_anatomical_stats -th3 -mgz -f ../stats/rh.BA_exvivo.stats -b -a ./rh.BA_exvivo.annot -c ./BA_exvivo.ctab sub-wlsubj001 rh white 


 mris_anatomical_stats -th3 -mgz -f ../stats/rh.BA_exvivo.thresh.stats -b -a ./rh.BA_exvivo.thresh.annot -c ./BA_exvivo.thresh.ctab sub-wlsubj001 rh white 

