
.autodepend
.silent

# Debug version
!ifdef DEBUG
    _D = _d
!endif

# Directories
INCLUDE_DIR    = ..\..
BCC_INCLUDE    = $(MAKEDIR)\..\include
SRCDIR         = "."
OBJDIR         = "..\..\build\Borland"

# Object files
OBJS = \
    $(OBJDIR)\americanmcengines.obj$(_D) \
    $(OBJDIR)\analyticeuropeanengine.obj$(_D) \
    $(OBJDIR)\binomialvanillaengine.obj$(_D) \
    $(OBJDIR)\discretizedvanillaoption.obj$(_D) \
    $(OBJDIR)\integralengines.obj$(_D) \
    $(OBJDIR)\mcbarrierengine.obj$(_D)


# Tools to be used
CC        = bcc32
TLIB      = tlib



# Options
CC_OPTS        = -vi- -q -c -tWM \
    -I$(INCLUDE_DIR) \
    -I$(BCC_INCLUDE) \
    -n$(OBJDIR)

!ifdef DEBUG
CC_OPTS = $(CC_OPTS) -v -DQL_DEBUG
!endif
!ifdef SAFE
CC_OPTS = $(CC_OPTS) -DQL_EXTRA_SAFETY_CHECKS
!endif

TLIB_OPTS    = /P128
!ifdef DEBUG
TLIB_OPTS    = /P128
!endif

# Generic rules
{$(SRCDIR)}.cpp{$(OBJDIR)}.obj:
    $(CC) $(CC_OPTS) $<
{$(SRCDIR)}.cpp{$(OBJDIR)}.obj$(_D):
    $(CC) $(CC_OPTS) -o$@ $<

# Primary target:
# static library
$(OBJDIR)\PricingEngines$(_D).lib:: $(OBJDIR) $(OBJS)
    if exist $(OBJDIR)\PricingEngines$(_D).lib     del $(OBJDIR)\PricingEngines$(_D).lib
    $(TLIB) $(TLIB_OPTS) $(OBJDIR)\PricingEngines$(_D).lib /a $(OBJS)

#create build dir
$(OBJDIR):
        @if not exist $(OBJDIR) (md $(OBJDIR))

# Clean up
clean::
    if exist $(OBJDIR)\*.obj         del /q $(OBJDIR)\*.obj
    if exist $(OBJDIR)\*.obj$(_D)    del /q $(OBJDIR)\*.obj
    if exist $(OBJDIR)\*.lib         del /q $(OBJDIR)\*.lib
