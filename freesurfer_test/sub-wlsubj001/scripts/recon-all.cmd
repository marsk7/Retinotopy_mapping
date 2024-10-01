

#---------------------------------
# New invocation of recon-all Mon Apr  6 16:55:07 EDT 2020 

 mri_convert /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/sub-wlsubj001/ses-anat/anat/sub-wlsubj001_ses-anat_acq-highres_run-01_T1w.nii.gz /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/mri/orig/001.mgz 

#--------------------------------------------
#@# MotionCor Mon Apr  6 16:55:17 EDT 2020

 cp /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/mri/orig/001.mgz /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/mri/rawavg.mgz 


 mri_convert /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/mri/rawavg.mgz /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/mri/orig.mgz --conform_min 


 mri_add_xform_to_header -c /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/mri/transforms/talairach.xfm /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/mri/orig.mgz /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/mri/orig.mgz 

#--------------------------------------------
#@# Talairach Mon Apr  6 16:55:32 EDT 2020

 mri_nu_correct.mni --no-rescale --i orig.mgz --o orig_nu.mgz --n 1 --proto-iters 1000 --distance 50 


 talairach_avi --i orig_nu.mgz --xfm transforms/talairach.auto.xfm 

talairach_avi log file is transforms/talairach_avi.log...

 cp transforms/talairach.auto.xfm transforms/talairach.xfm 

#--------------------------------------------
#@# Talairach Failure Detection Mon Apr  6 17:02:26 EDT 2020

 talairach_afd -T 0.005 -xfm transforms/talairach.xfm 


 awk -f /opt/freesurfer/bin/extract_talairach_avi_QA.awk /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/mri/transforms/talairach_avi.log 


 tal_QC_AZS /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/mri/transforms/talairach_avi.log 

#--------------------------------------------
#@# Nu Intensity Correction Mon Apr  6 17:02:26 EDT 2020

 mri_nu_correct.mni --i orig.mgz --o nu.mgz --uchar transforms/talairach.xfm --cm --n 2 


 mri_add_xform_to_header -c /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/mri/transforms/talairach.xfm nu.mgz nu.mgz 

#--------------------------------------------
#@# Intensity Normalization Mon Apr  6 17:17:27 EDT 2020

 mri_normalize -g 1 -mprage -noconform nu.mgz T1.mgz 



#---------------------------------
# New invocation of recon-all Mon Apr  6 17:22:40 EDT 2020 
#-------------------------------------
#@# EM Registration Mon Apr  6 17:22:40 EDT 2020

 mri_em_register -rusage /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/touch/rusage.mri_em_register.dat -uns 3 -mask brainmask.mgz nu.mgz /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.lta 

#--------------------------------------
#@# CA Normalize Mon Apr  6 17:27:31 EDT 2020

 mri_ca_normalize -c ctrl_pts.mgz -mask brainmask.mgz nu.mgz /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.lta norm.mgz 

#--------------------------------------
#@# CA Reg Mon Apr  6 17:30:50 EDT 2020

 mri_ca_register -rusage /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/touch/rusage.mri_ca_register.dat -nobigventricles -T transforms/talairach.lta -align-after -mask brainmask.mgz norm.mgz /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.m3z 

#--------------------------------------
#@# SubCort Seg Mon Apr  6 19:31:49 EDT 2020

 mri_ca_label -relabel_unlikely 9 .3 -prior 0.5 -align norm.mgz transforms/talairach.m3z /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca aseg.auto_noCCseg.mgz 


 mri_cc -aseg aseg.auto_noCCseg.mgz -o aseg.auto.mgz -lta /beegfs/cbi/work/data/wlsubj001.bOVWwnxx/data/derivatives/freesurfer/sub-wlsubj001/mri/transforms/cc_up.lta sub-wlsubj001 

#--------------------------------------
#@# Merge ASeg Mon Apr  6 20:43:58 EDT 2020

 cp aseg.auto.mgz aseg.presurf.mgz 

#--------------------------------------------
#@# Intensity Normalization2 Mon Apr  6 20:43:58 EDT 2020

 mri_normalize -mprage -aseg aseg.presurf.mgz -mask brainmask.mgz norm.mgz brain.mgz 

#--------------------------------------------
#@# Mask BFS Mon Apr  6 20:49:47 EDT 2020

 mri_mask -T 5 brain.mgz brainmask.mgz brain.finalsurfs.mgz 

#--------------------------------------------
#@# WM Segmentation Mon Apr  6 20:49:55 EDT 2020

 mri_segment -mprage brain.mgz wm.seg.mgz 


 mri_edit_wm_with_aseg -keep-in wm.seg.mgz brain.mgz aseg.presurf.mgz wm.asegedit.mgz 


 mri_pretess wm.asegedit.mgz wm norm.mgz wm.mgz 

#--------------------------------------------
#@# Fill Mon Apr  6 20:53:06 EDT 2020

 mri_fill -a ../scripts/ponscc.cut.log -xform transforms/talairach.lta -segmentation aseg.auto_noCCseg.mgz wm.mgz filled.mgz 



#---------------------------------
# New invocation of recon-all Mon Apr  6 23:07:52 EDT 2020 
#--------------------------------------------
#@# Cortical ribbon mask Mon Apr  6 23:07:53 EDT 2020

 mris_volmask --aseg_name aseg.presurf --label_left_white 2 --label_left_ribbon 3 --label_right_white 41 --label_right_ribbon 42 --save_ribbon sub-wlsubj001 



#---------------------------------
# New invocation of recon-all Mon Apr  6 23:32:26 EDT 2020 
#-----------------------------------------
#@# Relabel Hypointensities Mon Apr  6 23:32:26 EDT 2020

 mri_relabel_hypointensities aseg.presurf.mgz ../surf aseg.presurf.hypos.mgz 

#-----------------------------------------
#@# AParc-to-ASeg aparc Mon Apr  6 23:33:04 EDT 2020

 mri_aparc2aseg --s sub-wlsubj001 --volmask --aseg aseg.presurf.hypos --relabel mri/norm.mgz mri/transforms/talairach.m3z /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca mri/aseg.auto_noCCseg.label_intensities.txt 

#-----------------------------------------
#@# AParc-to-ASeg a2009s Mon Apr  6 23:42:22 EDT 2020

 mri_aparc2aseg --s sub-wlsubj001 --volmask --aseg aseg.presurf.hypos --relabel mri/norm.mgz mri/transforms/talairach.m3z /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca mri/aseg.auto_noCCseg.label_intensities.txt --a2009s 

#-----------------------------------------
#@# AParc-to-ASeg DKTatlas Mon Apr  6 23:51:43 EDT 2020

 mri_aparc2aseg --s sub-wlsubj001 --volmask --aseg aseg.presurf.hypos --relabel mri/norm.mgz mri/transforms/talairach.m3z /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca mri/aseg.auto_noCCseg.label_intensities.txt --annot aparc.DKTatlas --o mri/aparc.DKTatlas+aseg.mgz 

#-----------------------------------------
#@# APas-to-ASeg Tue Apr  7 00:01:00 EDT 2020

 apas2aseg --i aparc+aseg.mgz --o aseg.mgz 

#--------------------------------------------
#@# ASeg Stats Tue Apr  7 00:01:09 EDT 2020

 mri_segstats --seg mri/aseg.mgz --sum stats/aseg.stats --pv mri/norm.mgz --empty --brainmask mri/brainmask.mgz --brain-vol-from-seg --excludeid 0 --excl-ctxgmwm --supratent --subcortgray --in mri/norm.mgz --in-intensity-name norm --in-intensity-units MR --etiv --surf-wm-vol --surf-ctx-vol --totalgray --euler --ctab /opt/freesurfer/ASegStatsLUT.txt --subject sub-wlsubj001 

#-----------------------------------------
#@# WMParc Tue Apr  7 00:02:15 EDT 2020

 mri_aparc2aseg --s sub-wlsubj001 --labelwm --hypo-as-wm --rip-unknown --volmask --o mri/wmparc.mgz --ctxseg aparc+aseg.mgz 


 mri_segstats --seg mri/wmparc.mgz --sum stats/wmparc.stats --pv mri/norm.mgz --excludeid 0 --brainmask mri/brainmask.mgz --in mri/norm.mgz --in-intensity-name norm --in-intensity-units MR --subject sub-wlsubj001 --surf-wm-vol --ctab /opt/freesurfer/WMParcStatsLUT.txt --etiv 

