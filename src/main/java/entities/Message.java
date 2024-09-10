package entities;

public class Message {
    private String content;
    private String type;
    private String cssClass;

    public Message(String content, String type, String cssClass) {
        this.content = content;
        this.type = type;
        this.cssClass = cssClass;
    }

    public String getContent() {
        return content;
    }

    public String getType() {
        return type;
    }

    public String getCssClass() {
        return cssClass;
    }
}
