CLASS LHC_ZR_7109_BOOKING DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
          REQUEST requested_authorizations FOR Zr7109Booking
        RESULT result,

      setBeginDate FOR DETERMINE ON SAVE
        IMPORTING keys FOR Zr7109Booking~setBeginDate.
ENDCLASS.

CLASS LHC_ZR_7109_BOOKING IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.

  METHOD setBeginDate.
    READ ENTITIES OF Zr_7109_Booking IN LOCAL MODE
      ENTITY Zr7109Booking
      FIELDS ( BeginDate )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_bookings).

    DELETE lt_bookings WHERE BeginDate IS NOT INITIAL.

    MODIFY ENTITIES OF Zr_7109_Booking IN LOCAL MODE
      ENTITY Zr7109Booking
      UPDATE FIELDS ( BeginDate )
      WITH VALUE #(
        FOR ls_booking IN lt_bookings (
          %tky = ls_booking-%tky
          BeginDate = cl_abap_context_info=>get_system_date( )
        )
      ).
  ENDMETHOD.

ENDCLASS.
