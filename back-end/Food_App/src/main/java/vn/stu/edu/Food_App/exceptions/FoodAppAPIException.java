package vn.stu.edu.Food_App.exceptions;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public class FoodAppAPIException extends RuntimeException{
    private final HttpStatus status;
    private final String message;

    public FoodAppAPIException(HttpStatus status, String message) {
        this.status = status;
        this.message = message;
    }
}
