*"* use this source file for your ABAP unit test classes
class ltcl_booking_supplement definition final for testing
  duration short
  risk level harmless.

  private section.
    methods:
      first_test for testing raising cx_static_check.
endclass.


CLASS ltcl_booking_supplement IMPLEMENTATION.

  METHOD first_test.
    DATA(lo_book_suplement) = NEW zcl_7109_booking_supplement(
      iv_travel_id = '0097'
      iv_booking_id = '0001'
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lo_book_suplement->supplement_price
      exp = '4.50'
    ).
  ENDMETHOD.

endclass.
