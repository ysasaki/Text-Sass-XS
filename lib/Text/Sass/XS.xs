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
compile(char* package, char* source_string, ...)
INIT:
    char* output_string;
    struct sass_context* context = sass_new_context();

    context->source_string = source_string;
    context->output_string = output_string;

    if ( items > 2 ) {
        // TODO need to check svtype?
        if (!SvROK(ST(2))) {
            Perl_croak(aTHX_ "Text::Sass::XS->compile(source_string, options): options must be a HashRef");
        }

        HV* hv = (HV*) SvRV(ST(2));
        context->options.output_style    = hv_fetch_iv(hv, "output_style");
        context->options.source_comments = hv_fetch_iv(hv, "source_comments");
        context->options.include_paths   = hv_fetch_pv(hv, "include_paths");
        context->options.image_path      = hv_fetch_pv(hv, "image_path");
    }
    else {
        struct sass_options options = {
            SASS_STYLE_COMPRESSED,
            SASS_SOURCE_COMMENTS_NONE,
            NULL,
            NULL
        };
        context->options = options;
    }
CODE:
{
    sass_compile(context);
    if ( context->error_status ) {
        Perl_croak(aTHX_ "%s", context->error_message);
    }
    RETVAL = context->output_string;
}
OUTPUT:
    RETVAL
