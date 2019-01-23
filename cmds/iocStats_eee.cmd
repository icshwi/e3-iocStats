require iocStats,3.1.14

epicsEnvSet("SEC", "EEE")
epicsEnvSet("SUB", "EEE")
epicsEnvSet("P", "$(SEC)-$(SUB):")
epicsEnvSet("DIS", "DIS")
epicsEnvSet("DEV", "DEV-01")
epicsEnvSet("R", "$(DIS)-$(DEV)")
epicsEnvSet("IOCNAME", "$(P)$(R)")

dbLoadTemplate("iocAdminSoft.substitutions", "IOC=$(IOCNAME)-IocStats")

iocInit()

dbl > "${IOCNAME}_PVs.list"
