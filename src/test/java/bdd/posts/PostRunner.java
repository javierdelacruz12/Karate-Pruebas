package bdd.posts;

import com.intuit.karate.junit5.Karate;

public class PostRunner {
    @Karate.Test
    Karate testPost() {

        return Karate.run("Post").relativeTo(getClass());
    }

}
