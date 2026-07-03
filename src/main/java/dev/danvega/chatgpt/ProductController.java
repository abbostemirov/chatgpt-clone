package dev.danvega.chatgpt;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class ProductController {


    @GetMapping("/products")
    public Map<String, Double> getProducts() {

        return Map.of("olma", 15d, "nok", 20d);
    }
}
