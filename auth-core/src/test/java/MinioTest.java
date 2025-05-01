import org.junit.jupiter.api.Test;

import java.text.SimpleDateFormat;
import java.util.Date;

public class MinioTest {

    @Test
    void test() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM-dd");
        String date = formatter.format(new Date());
        System.out.println(date);
    }
}
