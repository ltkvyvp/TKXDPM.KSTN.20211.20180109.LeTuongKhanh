package controller;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;

import static org.junit.jupiter.api.Assertions.*;

class ValidateNameTest {

    private PlaceOrderController placeOrderController;

    @BeforeEach
    void setUp() throws Exception{
        placeOrderController = new PlaceOrderController();
    }

    @ParameterizedTest
    @CsvSource({
            ", false",
            "Nguyễn \\ Văn ??, false",
            "Nguyen Van An, true",
            "Tran $ Se Gay, false",
            "Bui1234, false",
            "Lê 9999, false"

    })
    void validateName(String name, boolean expected) {
        boolean isValid = placeOrderController.validateName(name);

        assertEquals(expected, isValid);
    }
}