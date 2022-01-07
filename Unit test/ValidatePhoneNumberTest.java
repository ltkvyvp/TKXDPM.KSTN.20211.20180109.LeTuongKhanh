package controller;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;

import static org.junit.jupiter.api.Assertions.*;

class ValidatePhoneNumberTest {

    private PlaceOrderController placeOrderController;

    @BeforeEach
    void setUp() throws Exception{
        placeOrderController = new PlaceOrderController();
    }

    @ParameterizedTest
    @CsvSource({
            ",false",
            "Nguyễn \\ Văn ??,false",
            "12333333,false",
            "0147896325, true",
            "013333, false",
            "1234567890, false",
            "11212323777, false"
    })
    void validatePhoneNumber(String phone, boolean expected) {
        boolean isValid = placeOrderController.validatePhoneNumber(phone);

        assertEquals(expected, isValid);
    }
}