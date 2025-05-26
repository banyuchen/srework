### https://live.douyin.com/918240048709
### https://XXXXXarch/aweme/?room_id={room_id}

import requests

def fetch_douyin_live(url: str) -> None:
    headers = {
        "User-Agent": (
            "Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) "
            "AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 "
            "Mobile/15E148 Safari/604.1"
        )
    }
    try:
        response = requests.get(url, headers=headers, timeout=10)
        response.raise_for_status()
        # 抓取的是网页内容，非 json，打印文本内容
        print(response.text)
    except requests.RequestException as e:
        print(f"请求失败: {e}")

if __name__ == "__main__":
    fetch_douyin_live("https://live.douyin.com/918240048709")