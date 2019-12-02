# FIXME ps7_cortex9_0
createbsp -name standalone_bsp_0 -hwproject hw_platform_0 -proc ps7_cortexa9_0 -os standalone
createapp -name app -app {Empty Application} -bsp standalone_bsp_0 -hwproject hw_platform_0 -proc ps7_cortexa9_0
