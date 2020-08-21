# Retrieve project permissions via SQL

## Original Links

- [x] Original Technet URL [Retrieve project permissions via SQL](https://gallery.technet.microsoft.com/Retrieve-permissions-via-f5ba6daa)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Retrieve-permissions-via-f5ba6daa/description)
- [x] Download: [Download Link](Download\Project_Permissions.sql)

## Output from Technet Gallery

SQL

```
--2010 version
SELECT proj_name as project,r.res_name as who,wc.CONV_string as permission
  FROM [MSP_WEB_SECURITY_SP_CAT_PERMISSIONS] scp
  inner join [MSP_WEB_SECURITY_SP_CAT_RELATIONS] scr on scr.WSEC_REL_UID =scp.WSEC_REL_UID
  inner join [MSP_WEB_SECURITY_PROJECT_CATEGORIES] spc on spc.WSEC_CAT_UID =scr.WSEC_CAT_UID
  inner join msp_projects p on spc.PROJ_UID =p.proj_uid
  inner join msp_resources r on scr.WSEC_SP_GUID =r.RES_SECURITY_GUID
  inner join [MSP_WEB_SECURITY_FEATURES_ACTIONS] sfa on sfa.WSEC_FEA_ACT_UID =scp.WSEC_FEA_ACT_UID
  inner join [MSP_WEB_CONVERSIONS] wc on wc.CONV_VALUE =sfa.WSEC_FEA_ACT_NAME_ID
  where wc.LANG_ID=1033
  union
  SELECT proj_name as project,sg.WSEC_GRP_NAME as who,wc.CONV_string as permission
  FROM [MSP_WEB_SECURITY_SP_CAT_PERMISSIONS] scp
  inner join [MSP_WEB_SECURITY_SP_CAT_RELATIONS] scr on scr.WSEC_REL_UID =scp.WSEC_REL_UID
  inner join [MSP_WEB_SECURITY_PROJECT_CATEGORIES] spc on spc.WSEC_CAT_UID =scr.WSEC_CAT_UID
  inner join msp_projects p on spc.PROJ_UID =p.proj_uid
  inner join msp_web_security_groups sg on scr.WSEC_SP_GUID =sg.WSEC_GRP_GUID
  inner join [MSP_WEB_SECURITY_FEATURES_ACTIONS] sfa on sfa.WSEC_FEA_ACT_UID =scp.WSEC_FEA_ACT_UID
  inner join [MSP_WEB_CONVERSIONS] wc on wc.CONV_VALUE =sfa.WSEC_FEA_ACT_NAME_ID
  where wc.LANG_ID=1033
--2013 version:
SELECT proj_name as project,r.res_name as who,wc.CONV_string as permission
  FROM pub.[MSP_WEB_SECURITY_SP_CAT_PERMISSIONS] scp
  inner join pub.[MSP_WEB_SECURITY_SP_CAT_RELATIONS] scr on scr.WSEC_REL_UID =scp.WSEC_REL_UID
  inner join pub.[MSP_WEB_SECURITY_PROJECT_CATEGORIES] spc on spc.WSEC_CAT_UID =scr.WSEC_CAT_UID
  inner join pub.msp_projects p on spc.PROJ_UID =p.proj_uid
  inner join pub.MSP_WEB_SECURITY_CLAIMS c on c.SECURITY_GUID =scr.WSEC_SP_GUID
  inner join pub.msp_resources r on c.ENCODED_CLAIM =r.WRES_CLAIMS_ACCOUNT
  inner join pub.[MSP_WEB_SECURITY_FEATURES_ACTIONS] sfa on sfa.WSEC_FEA_ACT_UID =scp.WSEC_FEA_ACT_UID
  inner join pub.[MSP_WEB_CONVERSIONS] wc on wc.CONV_VALUE =sfa.WSEC_FEA_ACT_NAME_ID
  where wc.LANG_ID=1033
  union
  SELECT proj_name as project,sg.WSEC_GRP_NAME as who,wc.CONV_string as permission
  FROM pub.[MSP_WEB_SECURITY_SP_CAT_PERMISSIONS] scp
  inner join pub.[MSP_WEB_SECURITY_SP_CAT_RELATIONS] scr on scr.WSEC_REL_UID =scp.WSEC_REL_UID
  inner join pub.[MSP_WEB_SECURITY_PROJECT_CATEGORIES] spc on spc.WSEC_CAT_UID =scr.WSEC_CAT_UID
  inner join pub.msp_projects p on spc.PROJ_UID =p.proj_uid
  inner join pub.msp_web_security_groups sg on scr.WSEC_SP_GUID =sg.WSEC_GRP_GUID
  inner join pub.[MSP_WEB_SECURITY_FEATURES_ACTIONS] sfa on sfa.WSEC_FEA_ACT_UID =scp.WSEC_FEA_ACT_UID
  inner join pub.[MSP_WEB_CONVERSIONS] wc on wc.CONV_VALUE =sfa.WSEC_FEA_ACT_NAME_ID
  where wc.LANG_ID=1033
```

Project permissions allow the users to grant permissions themselves without an administrator being envolved. But this can make it difficult to get an overview who has permissions on which project.

With this SQL query you can get a list of all individual project permissions that have been granted in your PWA instance

Project Server 2010 and Project Server 2013 version. Works only on premise.

Exchange the language code 1033 (english) to the language you want to see for the permission strings (e.g. 1031 for german).

