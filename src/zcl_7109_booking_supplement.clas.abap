CLASS zcl_7109_booking_supplement DEFINITION
  PUBLIC
  INHERITING FROM zcl_7109_booking
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA supplement_price TYPE /dmo/supplement_price.

    METHODS constructor
      IMPORTING
        iv_travel_id  TYPE /dmo/travel_id
        iv_booking_id TYPE /dmo/booking_id.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_7109_booking_supplement IMPLEMENTATION.
  METHOD constructor.
    super->constructor(
      iv_travel_id = iv_travel_id
      iv_booking_id = iv_booking_id
    ).

    SELECT SINGLE price
      FROM /dmo/i_booksuppl_m
      WHERE travel_id = @iv_travel_id
        AND booking_id = @iv_booking_id
      INTO @supplement_price.

    IF supplement_price IS INITIAL.
      supplement_price = -1.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
