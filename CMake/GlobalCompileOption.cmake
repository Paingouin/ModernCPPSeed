

######---------MSVC-----------#######
set(MSVC_COMPILE_OPTION ${MSVC_COMPILE_OPTION}
/FS /Gy /Zi /MP /GS
/Zc:wchar_t /Gm- /fp:precise /WX- /Gd /EHa /Zc:forScope /nologo /wd"4251"
)

set(MSVC_COMPILE_OPTION_DEBUG ${MSVC_COMPILE_OPTION_DEBUG}
/Od /RTC1 
)

set(MSVC_COMPILE_OPTION_RELEASE ${MSVC_COMPILE_OPTION_RELEASE}
/O2 /GF /Ob1 /EHa /GF
)

set(MSVC_DEFINE_OPTION ${MSVC_DEFINE_OPTION}
_WINDOWS WIN32 _AFXDLL 
_64BITS NO_WARN_MBCS_MFC_DEPRECATION _CRT_SECURE_NO_WARNINGS XERCES311
)

set(MSVC_DEFINE_OPTION_DEBUG
_DEBUG _RWCONFIG_15d
)

set(MSVC_DEFINE_OPTION_RELEASE
 NDEBUG _RWCONFIG_12d
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
_LINUX XERCES311
)

set(GCC_DEFINE_OPTION_DEBUG
_RWCONFIG_15d _DEBUG
)

set(GCC_DEFINE_OPTION_RELEASE
 _RWCONFIG_12d
)

set(GCC_LINKER_OPTION
-ldl
)

set(GCC_LINKER_OPTION_DEBUG

)

set(GCC_LINKER_OPTION_RELEASE

)


function(configure_global_compile_options)

	add_library(project_global_options INTERFACE)
	
    set( DEFINE_OPTION  "")
    set( COMPILE_OPTION "")
	set( LINKER_OPTION  "")
	#set global options
	if(MSVC) 
		set( DEFINE_OPTION 
		     ${MSVC_DEFINE_OPTION}
		     $<IF:$<CONFIG:DEBUG>,${MSVC_DEFINE_OPTION_DEBUG}
					,${MSVC_DEFINE_OPTION_RELEASE}>
			 )
		set( COMPILE_OPTION 
		     ${MSVC_COMPILE_OPTION}
		     $<IF:$<CONFIG:DEBUG>,${MSVC_COMPILE_OPTION_DEBUG}
					,${MSVC_COMPILE_OPTION_RELEASE}>
			 )
			 
	     set( LINKER_OPTION 
		     ${MSVC_LINKER_OPTION}
		     $<IF:$<CONFIG:DEBUG>,${MSVC_LINKER_OPTION_DEBUG}
					,${MSVC_LINKER_OPTION_RELEASE}>
			 )	 
	endif()
	
	#Add them to the global project target
	target_compile_definitions(project_global_options INTERFACE 
			 ${DEFINE_OPTION}
		 )
		 
	target_compile_options(project_global_options INTERFACE 
		     ${COMPILE_OPTION} 
			 ${LINKER_OPTION}
		 )

endfunction()