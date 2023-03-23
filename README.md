# picmobi

- 免許返納後の高齢者等を対象に、移動が困難な者に向けた買い物をお助けするサービス。
- 利用者は商品を撮影するだけで、モビリティが商品を近所のハブに届けてくれる。
- 買い物をお助けし、コミュニティを大事するサービスを提供を目指す。

## ラズパイの設定

```
python3 -m venv venv
source venv/bin/activate
pip3 install --upgrade pip
pip3 install --upgrade firebase-admin
pip3 install gpsd-py3

# ラズパイにsshで接続
ssh 

# ラズパイにscpでファイルを転送
scp -r firebase-sdk.json user@raspberrypi.local:~/
```