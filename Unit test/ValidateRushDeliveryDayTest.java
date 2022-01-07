package controller;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;

import static org.junit.jupiter.api.Assertions.*;

class ValidateRushDeliveryDayTest {

    private PlaceRushOrderController placeRushOrderController;

    @BeforeEach
    void setUp() throws Exception{
        placeRushOrderController = new PlaceRushOrderController();
    }

    @ParameterizedTest
    @CsvSource({
            "012349, false",
            "@@!34, false",
            "abc123, false",
            "1, true",
            "20, true",
            "-21, false"
    })
    void validateRushDeliveryDay(String rushDay, boolean expected) {
        boolean isValid = placeRushOrderController.validateRushDeliveryDay(rushDay);

        assertEquals(expected, isValid);
    }
}