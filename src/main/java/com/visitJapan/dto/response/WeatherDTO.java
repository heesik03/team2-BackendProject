package com.visitJapan.dto.response;

public class WeatherDTO {
    // 하늘 상태 (맑음, 흐림 등)
    private String skyStatus;
    // 최고 기온
    private String highTemp;
    // 최저 기온
    private String lowTemp;
    // 강수 확률
    private String precipitation;

    public WeatherDTO() {}

    public WeatherDTO(String skyStatus, String highTemp, String lowTemp, String precipitation) {
        this.skyStatus = skyStatus;
        this.highTemp = highTemp;
        this.lowTemp = lowTemp;
        this.precipitation = precipitation;
    }

    public String getSkyStatus() {
        return skyStatus;
    }

    public void setSkyStatus(String skyStatus) {
        this.skyStatus = skyStatus;
    }

    public String getHighTemp() {
        return highTemp;
    }

    public void setHighTemp(String highTemp) {
        this.highTemp = highTemp;
    }

    public String getLowTemp() {
        return lowTemp;
    }

    public void setLowTemp(String lowTemp) {
        this.lowTemp = lowTemp;
    }

    public String getPrecipitation() {
        return precipitation;
    }

    public void setPrecipitation(String precipitation) {
        this.precipitation = precipitation;
    }
}

