#ifdef __cplusplus
extern "C" {
#endif

#define PERL_NO_GET_CONTEXT /* we want efficiency */
#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>

#ifdef __cplusplus
} /* extern "C" */
#endif

#define NEED_newSVpvn_flags
#include "ppport.h"
#include "sass_interface.h"

#define _CONST(name) \
    newCONSTSUB(stash, #name, newSViv(name))

MODULE = Text::Sass::XS    PACKAGE = Text::Sass::XS

PROTOTYPES: DISABLE

BOOT:
{
    HV* stash = gv_stashpv("Text::Sass::XS", 1);

    _CONST(SASS_STYLE_NESTED);
    _CONST(SASS_STYLE_EXPANDED);
    _CONST(SASS_STYLE_COMPACT);
    _CONST(SASS_STYLE_COMPRESSED);
    _CONST(SASS_SOURCE_COMMENTS_NONE);
    _CONST(SASS_SOURCE_COMMENTS_DEFAULT);
    _CONST(SASS_SOURCE_COMMENTS_MAP);
}

void
hello()
CODE:
{
    ST(0) = newSVpvs_flags("Hello, world!", SVs_TEMP);
}


struct sass_context*
sass_new_context()

struct sass_file_context*
sass_new_file_context()

struct sass_folder_context*
sass_new_folder_context()

void
sass_free_context(struct sass_context* ctx)

void
sass_free_file_context(struct sass_file_context* ctx)

void
sass_free_folder_context(struct sass_folder_context* ctx);

int
sass_compile(struct sass_context* ctx);

int
sass_compile_file(struct sass_file_context* ctx);

int
sass_compile_folder(struct sass_folder_context* ctx);
