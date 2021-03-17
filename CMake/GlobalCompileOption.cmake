

######---------MSVC-----------#######
set(MSVC_COMPILE_OPTION
/FS /Gy /Zi /MP /GS
/Zc:wchar_t /Gm- /fp:precise /WX- /Gd /EHa /Zc:forScope /nologo /wd"4251"
)

set(MSVC_COMPILE_OPTION_DEBUG
/Od /RTC1 
)

set(MSVC_COMPILE_OPTION_RELEASE
/O2 /GF /Ob1 /EHa /GF
)

set(MSVC_DEFINE_OPTION
/D_WINDOWS /DWIN32 /D_AFXDLL /D_64BITS /DNO_WARN_MBCS_MFC_DEPRECATION /D_CRT_SECURE_NO_WARNINGS /DXERCES311
)

set(MSVC_DEFINE_OPTION_DEBUG
/D_DEBUG /D_RWCONFIG_15d
)

set(MSVC_DEFINE_OPTION_RELEASE
 /DNDEBUG /D_RWCONFIG_12d
)

set(MSVC_LINKER_OPTION

)

set(MSVC_LINKER_OPTION_DEBUG

)

set(MSVC_LINKER_OPTION_RELEASE

)



######---------GCC-----------#######
set(GCC_COMPILE_OPTION
-std=gnu++11 -m64
)

set(GCC_COMPILE_OPTION_DEBUG
-g -fprofile-arcs -ftest-coverage -fPIC
)

set(GCC_COMPILE_OPTION_RELEASE
-O3 -fPIC 
)

set(GCC_DEFINE_OPTION
-D_LINUX -DXERCES311
)

set(GCC_DEFINE_OPTION_DEBUG
-D_RWCONFIG_15d -D_DEBUG
)

set(GCC_DEFINE_OPTION_RELEASE
 -D_RWCONFIG_12d
)

set(GCC_LINKER_OPTION
-ldl
)

set(GCC_LINKER_OPTION_DEBUG

)

set(GCC_LINKER_OPTION_RELEASE

)

#AIX



function(set_project_compile_options target_name)

	if(MSVC)
		target_compile_definitions(${target_name} PUBLIC 
			${MSVC_DEFINE_OPTION}
			$<IF:$<CONFIG:DEBUG>,${MSVC_DEFINE_OPTION_DEBUG},${MSVC_DEFINE_OPTION_RELEASE}>
		 )
		 
		 target_compile_options(${target_name} PUBLIC 
		     ${MSVC_COMPILE_OPTION}
			 $<IF:$<CONFIG:DEBUG>,${MSVC_COMPILE_OPTION_DEBUG},${MSVC_COMPILE_OPTION_RELEASE}>
		 )
		 
	

	endif()

endfunction()