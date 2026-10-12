let Lookback = 30m;
let KMS_Indicator = dynamic([
  "autokms",
  "kmsauto",
  "kmsauto++",
  "kmspico",
  "hwidgen",
  "aact",
  "kmsauto_files",
  "sppextcomobjhook.dll",
  "sppextcomobjhook",
  "vlmcs"
]);
let LicensingCmd = dynamic([
  "slmgr",
  "ospp.vbs",
  "cscript",
  "wscript",
  "softwareprotectionplatform"
]);
let LicensingSwitches = dynamic([
  "/skms", "-skms",
  "/ckms", "-ckms",
  "/ato",  "-ato",
  "/ipk",  "-ipk",
  "sethst", "setprt"
]);
let LOLBins = dynamic([
  "powershell.exe",
  "cmd.exe",
  "rundll32.exe",
  "mshta.exe",
  "wscript.exe",
  "cscript.exe"
]);
DeviceProcessEvents
| where TimeGenerated > ago(Lookback)
| where isnotempty(ProcessCommandLine)
| where not (
    FileName =~ "msiexec.exe"
    and ProcessCommandLine has_any (" -Embedding", "Global\\MSI", "/i", "/x", "/qn", "/quiet", "/V", "MsiExec.exe -Embedding")
)
| where (
    FileName has_any (KMS_Indicator)
    or ProcessCommandLine has_any (KMS_Indicator)
    or (
        ProcessCommandLine has_any (LicensingCmd)
        and ProcessCommandLine has_any (LicensingSwitches)
    )
    or (
        FileName in~ (LOLBins)
        and ProcessCommandLine has_any (KMS_Indicator)
    )
)
| extend FileSizeMB = round(InitiatingProcessFileSize / (1024.0 * 1024.0), 2)
| extend DetectionReason = case(
    FileName has_any (KMS_Indicator), "KMS indicator in filename",
    ProcessCommandLine has_any (KMS_Indicator), "KMS indicator in command line",
    (ProcessCommandLine has_any (LicensingCmd) and ProcessCommandLine has_any (LicensingSwitches)), "Licensing abuse switches",
    (FileName in~ (LOLBins) and ProcessCommandLine has_any (KMS_Indicator)), "LOLBins used to launch KMS indicator",
    "Other"
)
| summarize
    FirstSeenUTC=min(TimeGenerated),
    Reasons=make_set(DetectionReason),
    ProcessNames=make_set(FileName),
    CmdLines=make_set(ProcessCommandLine, 50),
    Initiators=make_set(InitiatingProcessFileName, 50),
    InitiatingProcessMD5=make_set(InitiatingProcessMD5, 50),
    InitiatingProcessFolderPath=make_set(InitiatingProcessFolderPath,50),
    File_Size_MB =make_set(FileSizeMB,50)
by DeviceName, AccountName
| extend FirstSeenBD = format_datetime(datetime_add("hour", 6, FirstSeenUTC), "dd-MM-yyyy HH:mm:ss.fff")
| order by FirstSeenBD desc