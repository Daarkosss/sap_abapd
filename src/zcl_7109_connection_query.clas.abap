CLASS zcl_7109_connection_query DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ts_connection,
      airport_from_id TYPE /dmo/airport_from_id,
      airport_to_id TYPE /dmo/airport_to_id,
      airport_via_id TYPE /dmo/airport_to_id,
    END OF ts_connection.
    TYPES tt_connections TYPE STANDARD TABLE OF ts_connection WITH EMPTY KEY.

    METHODS determine_connections
      IMPORTING
          i_destination TYPE /dmo/airport_to_id
      RETURNING
          VALUE(r_connections) TYPE tt_connections.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_7109_connection_query IMPLEMENTATION.
  METHOD determine_connections.
    SELECT DISTINCT
      airport_from_id,
      airport_to_id,
      ' ' AS airport_via_id
    FROM /dmo/connection
    WHERE airport_to_id = @i_destination
      AND airport_from_id <> @i_destination
    UNION
    SELECT DISTINCT
      a~airport_from_id,
      b~airport_to_id,
      b~airport_from_id AS airport_via_id
    FROM /dmo/connection AS a
    INNER JOIN /dmo/connection AS b
      ON b~connection_id <> a~connection_id
      AND b~airport_from_id = a~airport_to_id
      AND b~airport_to_id <> a~airport_from_id
    WHERE b~airport_to_id = @i_destination
      AND a~airport_from_id <> @i_destination
    INTO TABLE @r_connections.

  ENDMETHOD.

ENDCLASS.
