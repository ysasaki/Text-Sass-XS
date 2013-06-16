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

static int hv_fetch_iv(pTHX_ HV* dict, const char* key) {
    if (!hv_exists(dict, key, strlen(key))) {
        return 0;
    }

    SV** svv = hv_fetch(dict, key, strlen(key), 0);
    if (!SvIOKp(*svv)) {
        Perl_croak(aTHX_ "Error %s is not integer.", key);
    }
    return SvIV(*svv);
}

static char* hv_fetch_pv(pTHX_ HV* dict, const char* key) {
    if (!hv_exists(dict, key, strlen(key))) {
        return NULL;
    }

    SV** svv = hv_fetch(dict, key, strlen(key), 0);
    if (!SvOK(*svv)) {
        return NULL;
    }
    if (!SvPOK(*svv)) {
        Perl_croak(aTHX_ "Error %s is not string.", key);
    }
    return SvPV_nolen(*svv);
}

static void set_options(pTHX_ void* context, HV* options) {
    struct sass_context* ctx = (struct sass_context*) context;
    if ( options == NULL ) {
        struct sass_options default_options = {
            SASS_STYLE_COMPRESSED,
            SASS_SOURCE_COMMENTS_NONE,
            NULL,
            NULL
        };
        ctx->options = default_options;
    }
    else {
        ctx->options.output_style    = hv_fetch_iv(options, "output_style");
        ctx->options.source_comments = hv_fetch_iv(options, "source_comments");
        ctx->options.include_paths   = hv_fetch_pv(options, "include_paths");
        ctx->options.image_path      = hv_fetch_pv(options, "image_path");
    }
}

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

char*
compile(source_string, options=NULL)
    const char* source_string;
    HV* options;
PREINIT:
    char* output_string;
    char* error_message;
    struct sass_context* context = sass_new_context();
INIT:
    context->source_string = source_string;
    context->output_string = output_string;
    set_options(context, options);
CODE:
    sass_compile(context);
    if ( context->error_status ) {
        error_message = context->error_message;
        sass_free_context(context);
        Perl_croak(aTHX_ "%s", error_message);
    }
    RETVAL = context->output_string;
OUTPUT:
    RETVAL
CEANUP:
    sass_free_context(context);


char*
compile_file(input_path, options=NULL)
    char* input_path;
    HV* options;
PREINIT:
    char* output_string;
    char* error_message;
    struct sass_file_context* context = sass_new_file_context();
INIT:
    context->input_path    = input_path;
    context->output_string = output_string;
    set_options(context, options);
CODE:
    sass_compile_file(context);
    if ( context->error_status ) {
        error_message = context->error_message;
        sass_free_file_context(context);
        Perl_croak(aTHX_ "%s", error_message);
    }
    RETVAL = context->output_string;
OUTPUT:
    RETVAL
CEANUP:
    sass_free_file_context(context);
