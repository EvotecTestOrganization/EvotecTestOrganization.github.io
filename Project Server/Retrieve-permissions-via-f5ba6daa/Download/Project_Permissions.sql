
SELECT proj_name as project,r.res_name as who,wc.CONV_string as permission
  FROM [MSP_WEB_SECURITY_SP_CAT_PERMISSIONS] scp 
  inner join [MSP_WEB_SECURITY_SP_CAT_RELATIONS] scr on scr.WSEC_REL_UID =scp.WSEC_REL_UID
  inner join [MSP_WEB_SECURITY_PROJECT_CATEGORIES] spc on spc.WSEC_CAT_UID =scr.WSEC_CAT_UID
  inner join msp_projects p on spc.PROJ_UID =p.proj_uid
  inner join msp_resources r on scr.WSEC_SP_GUID =r.RES_SECURITY_GUID
  inner join [MSP_WEB_SECURITY_FEATURES_ACTIONS] sfa on sfa.WSEC_FEA_ACT_UID =scp.WSEC_FEA_ACT_UID 
  inner join [MSP_WEB_CONVERSIONS] wc on wc.CONV_VALUE =sfa.WSEC_FEA_ACT_NAME_ID
  where wc.LANG_ID=1033
  
  union

  SELECT proj_name as project,sg.WSEC_GRP_NAME as who,wc.CONV_string as permission
  FROM [MSP_WEB_SECURITY_SP_CAT_PERMISSIONS] scp 
  inner join [MSP_WEB_SECURITY_SP_CAT_RELATIONS] scr on scr.WSEC_REL_UID =scp.WSEC_REL_UID
  inner join [MSP_WEB_SECURITY_PROJECT_CATEGORIES] spc on spc.WSEC_CAT_UID =scr.WSEC_CAT_UID
  inner join msp_projects p on spc.PROJ_UID =p.proj_uid
  inner join msp_web_security_groups sg on scr.WSEC_SP_GUID =sg.WSEC_GRP_GUID
  inner join [MSP_WEB_SECURITY_FEATURES_ACTIONS] sfa on sfa.WSEC_FEA_ACT_UID =scp.WSEC_FEA_ACT_UID 
  inner join [MSP_WEB_CONVERSIONS] wc on wc.CONV_VALUE =sfa.WSEC_FEA_ACT_NAME_ID
  where wc.LANG_ID=1033
  