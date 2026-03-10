CLASS zcl_7109_booking DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA travel_id TYPE /dmo/travel_id READ-ONLY.
    DATA booking_id TYPE /dmo/booking_id READ-ONLY.

    METHODS constructor
      IMPORTING
        iv_travel_id  TYPE /dmo/travel_id
        iv_booking_id TYPE /dmo/booking_id.

  PROTECTED SECTION.
    DATA booking_date TYPE /dmo/booking_date.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_7109_booking IMPLEMENTATION.
  METHOD constructor.
    travel_id = iv_travel_id.
    booking_id = iv_booking_id.

    SELECT SINGLE booking_date
      FROM /dmo/booking
      WHERE travel_id = @travel_id
        AND booking_id = @booking_id
      INTO @booking_date.
  ENDMETHOD.

ENDCLASS.
