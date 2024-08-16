テストのメモ

## Create Cred

- (Relay経由｜Relayなし)で(SIGNATURE|MERKLE)(Eligible|ADVANCED)TypeのCredentiailを（ロイヤリティあり|ロイヤリティなし
  で）設定する

- 複数のVerifierを許可する
- 任意のVerifierを許可する

## Update Cred

- description/related linkを更新する
- verifierを追加する
- verifierを無効化する

## Signal

- Boding　Curveの最大まで購入する
- 自分以外のaddressのためにsinalingする
- Decent経由でERC20によるSignalingをする
- buyのFee分をphiの金庫が受け取る
- buyのロイヤリティ分をCred　Creatorが受け取る
- Batch BuyでSignalをする

## Unsignal

- 自分のShare　balance以上にsellできないことを確認する
- sellのFee分をphiの金庫が受け取る
- sellのロイヤリティ分をCred　Creatorが受け取る
- Batch SellでSignalをする
- UnSignalをした後にSignal状態でないことを確認する

## ArtCreator

- Rewardを受け取る
- ヘルスチェックに通らなかったArt生成のエンドポイントが停止する
- Receiveするaddressを変更する
- Cred　とは別のチェーンでアートを作成する

## Minter

- mintしたNFTの画像があっている
- mintしたNFTが確認できる
- mintしたNFTがOpenseaで確認できる
- mintしたNFTをtransferする

## Refferal

- 携帯からでもrefferalに報酬が流れる
- minter自身をrefferalにした場合は、receiver（artist）が受け取り先になる
- Rewardを受け取る

## Verifier

- 登録しているVerifierを更新できる
- VerifierのEndpointを停止する
- Rewardを受け取る
- ヘルスチェックに通らなかったVerfierのエンドポイントが停止する

## Curator

- 自身のSignal済みのCredが確認できる。
- Reward Distributorを実行してbalanceを追加する
- Rewardを受け取る
- 100人以上のCuratorの状態を処理できている

## Create Art

- (STATIC|Dynamic)Typeの(Free|Paid)Artを作成する。

## Update Art Setting

- claimのstarttimeを変更する
- claimのendtimeを変更する
- mintFeeを0.001ethから無料に変更する
- mintFeeを無料から0.001ethに変更する
- imageを生成するurlを更新する
- artをsoulbounderに変更する

## Factory Contract

- ArtCreatFeeを0.0001ethにする
- Contractをpauseする
- erc1155のコントラクトを変更する

## Art Royalty

- (STATIC|Dynamic)Typeの(Free|Paid)Artを作成する。

## NFT Claim

- (Base Sepolia|Optimism Sepolia)の(art|factory)Contractで検証方法が(SIGNATURE|MERKLE)(BASIC|ADVANCED)Typeの
  (Free|Paid)NFTを(自分のアドレス｜他のアドレス)に(1つ|複数)claimする
- Verifierのエンドポイントが失敗した時のフロントエンドが正しく動作する
- Artistの設定したエンドポイントが失敗した時のフロントエンドが正しく動作する
- Referrer経由でNFTをclaimする
- Decent経由でERC20によるNFTClaimをする
- batchClaimを実行する
- AAwalletでのclaimをする

## Reward

- 別チェーンのRewardをrelay経由でWithdrawをする
- Splitの設定をした場合のwithdrawができる
- CuratorのReward Contractの Addressを更新する

## Admin

- Claimの(artist|refferal|verifier|curator)Rewardを変更する
- cred Contractのowner権限を他のアドレスに設定する
- Cred Contractをpauseする
- PhiとしてのAttestationをCredに実行する
- 新しいbonding curveを追加するcontractをpauseする
