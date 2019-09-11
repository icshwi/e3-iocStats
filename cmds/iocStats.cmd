require iocStats,3.1.16

epicsEnvSet("SEC", "SEC")
epicsEnvSet("SUB", "SUB01")
epicsEnvSet("P", "$(SEC)-$(SUB):")
epicsEnvSet("DIS", "DIS")
epicsEnvSet("DEV", "DEV-01")
epicsEnvSet("R", "$(DIS)-$(DEV)")
epicsEnvSet("IOCNAME", "$(P)$(R)")


iocshLoad("$(iocStats_DIR)/iocStats.iocsh", "IOCNAME=$(IOCNAME)")

iocInit()

dbl > "${IOCNAME}_PVs.list"

