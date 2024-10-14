// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC3643_Token {
    // 토큰 잔액 저장
    mapping(address => uint256) private _balances;

    // 화이트리스트와 블랙리스트 관리
    mapping(address => bool) private _whitelist;
    mapping(address => bool) private _blacklist;

    // 발행자 주소 저장
    address public issuer;

    // 역할 관리 - 발행자, 관리자 설정
    mapping(address => bool) private _admins;

    // 이벤트 선언
    event TokenIssued(address indexed to, uint256 amount);
    event TokenRevoked(address indexed from, uint256 amount);
    event Whitelisted(address indexed account);
    event Blacklisted(address indexed account);

    // 수정자: 발행자만 실행 가능
    modifier onlyIssuer() {
        require(msg.sender == issuer, "Only issuer can perform this action");
        _;
    }

    // 수정자: 관리자인 경우만 실행 가능
    modifier onlyAdmin() {
        require(_admins[msg.sender], "Only admin can perform this action");
        _;
    }

    // 수정자: 화이트리스트에 등록된 계정만 가능
    modifier onlyWhitelisted(address account) {
        require(_whitelist[account], "Account is not whitelisted");
        _;
    }

    // 수정자: 블랙리스트에 등록되지 않은 계정만 가능
    modifier notBlacklisted(address account) {
        require(!_blacklist[account], "Account is blacklisted");
        _;
    }

    // 계약 생성자: 발행자 및 관리자 설정
    constructor() {
        issuer = msg.sender;
        _admins[msg.sender] = true;
    }

    // 화이트리스트에 추가
    function addWhitelist(address account) public onlyAdmin {
        _whitelist[account] = true;
        emit Whitelisted(account);
    }

    // 블랙리스트에 추가
    function addBlacklist(address account) public onlyAdmin {
        _blacklist[account] = true;
        emit Blacklisted(account);
    }

    // 토큰 발행: 발행자가 화이트리스트에 있는 계정에 토큰을 발행
    function issueToken(address to, uint256 amount) public onlyIssuer onlyWhitelisted(to) notBlacklisted(to) {
        _balances[to] += amount;
        emit TokenIssued(to, amount);
    }

    // 토큰 회수: 발행자가 특정 계정의 토큰을 회수
    function revokeToken(address from, uint256 amount) public onlyIssuer {
        require(_balances[from] >= amount, "Insufficient balance to revoke");
        _balances[from] -= amount;
        emit TokenRevoked(from, amount);
    }

    // 토큰 전송: 화이트리스트에 등록된 사용자만 토큰 전송 가능
    function transfer(address to, uint256 amount) public onlyWhitelisted(msg.sender) notBlacklisted(msg.sender) onlyWhitelisted(to) notBlacklisted(to) {
        require(_balances[msg.sender] >= amount, "Insufficient balance");
        _balances[msg.sender] -= amount;
        _balances[to] += amount;
    }

    // 관리자의 권한 추가 (역할 기반 제어)
    function addAdmin(address account) public onlyIssuer {
        _admins[account] = true;
    }

    // 관리자의 권한 제거 (역할 기반 제어)
    function removeAdmin(address account) public onlyIssuer {
        _admins[account] = false;
    }

    // 잔액 조회 함수
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    // 화이트리스트 여부 확인 함수
    function isWhitelisted(address account) public view returns (bool) {
        return _whitelist[account];
    }

    // 블랙리스트 여부 확인 함수
    function isBlacklisted(address account) public view returns (bool) {
        return _blacklist[account];
    }
}
