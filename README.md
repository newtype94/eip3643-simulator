# eip3643-simulator

eip3643-simulator(electron)

- node version 20.18.0

## eip3643-network

### 1. 네트워크 실행

```bash
npx hardhat node
```

## 기능

1. Whitelist 및 Blacklist 기능:

addWhitelist 및 addBlacklist 함수로 사용자를 화이트리스트나 블랙리스트에 추가할 수 있습니다.
onlyWhitelisted 및 notBlacklisted 수정자를 통해 특정 작업(토큰 발행, 전송 등)이 화이트리스트에 등록된 사용자만 가능하도록 제어합니다.

2. 토큰 발행 및 회수 기능:

issueToken 함수로 발행자가 토큰을 화이트리스트 사용자에게 발행합니다.
revokeToken 함수로 발행자가 필요에 따라 토큰을 회수할 수 있습니다.

3. 규제 준수 및 신원 인증:

화이트리스트와 블랙리스트를 통해 규제에 맞는 사용자만 토큰을 소유하거나 전송할 수 있게 제어합니다.

4. Transfer 및 Controlled Transfer 기능:

transfer 함수에서 화이트리스트에 등록된 사용자만이 전송할 수 있으며, 블랙리스트 사용자나 자격이 없는 사용자는 거래가 차단됩니다.

5. Regulatory Hooks (규제 후킹 기능):

onlyWhitelisted와 notBlacklisted 수정자를 통해 규정된 사용자만이 토큰 거래를 수행할 수 있습니다.

6. Role-based Access Control (역할 기반 접근 제어):

발행자는 addAdmin 및 removeAdmin을 통해 관리자를 추가하거나 제거할 수 있습니다. 관리자는 화이트리스트와 블랙리스트를 관리하는 역할을 합니다.

## 참고 링크

https://medium.com/decipher-media/sto-%EC%9D%B4%EB%8C%80%EB%A1%9C-%EA%B4%9C%EC%B0%AE%EC%9D%84%EA%B9%8C-%ED%95%98-d0163a98ac1e
