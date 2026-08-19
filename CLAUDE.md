# CLAUDE.md — tfmodule-aws-alb

이 문서는 Claude Code가 본 저장소에서 작업할 때 따르는 규칙과 컨텍스트를 정의한다. `TODO` 표시는 저장소를 직접 읽고 사람이 확정한다.

## 1. 프로젝트 개요

- 프로젝트명: `tfmodule-aws-alb`
- 기본 브랜치: `main`

AWS Application/Network Load Balancer(ALB/NLB)를 생성하는 재사용 가능한 테라폼 모듈이다. `aws_lb`, 리스너(HTTP/TCP, HTTPS), 리스너 룰, 타겟 그룹, 타겟 그룹 attachment를 하나의 모듈로 제공하며, `tfmodule-context` 모듈의 `context` 객체를 입력받아 표준화된 네이밍(`{name_prefix}-{lb_name}-{alb|nlb}`)과 공통 태그를 적용한다. Bespin Global의 OpsNow 인프라용 사내 테라폼 모듈 계열(`tfmodule-*`) 중 하나로, 애플리케이션이 아닌 라이브러리 성격의 저장소다.

## 2. 기술 스택

- Terraform 전용 저장소다. 별도 빌드 도구, 패키지 매니저, CI 파이프라인이 없다.
- 루트 모듈 요구 버전: Terraform >= 1.5.7, AWS Provider >= 6.0.0 (`versions.tf`).

## 3. 디렉터리 구조

최상위 디렉터리별 파일 분포는 다음과 같다.

| 경로 | 파일 수 | 역할 |
| --- | --- | --- |
| `example` | 21 | 실행 가능한 사용 예제. `simple`(HTTP), `alb-http`, `alb-https` 세 구성이 있으며 각각 `main.tf`, `data.tf`, `sg.tf`, `providers.tf`, `terraform.tfvars`로 구성된다 |
| `(root)` | 9 | 모듈 본체. `main.tf`(LB·리스너·리스너 룰), `target-group.tf`(타겟 그룹·attachment), `variables.tf`, `variables-context.tf`(context 입력), `output.tf`, `versions.tf` |
| `modules` | 3 | `modules/target-group`: ASG 연동용 독립 타겟 그룹 서브모듈. 루트 모듈과 별개로 단독 사용되는 레거시 성격의 모듈이며 루트 모듈이 호출하지 않는다 |

작업 전에 참고할 기존 문서는 다음과 같다.

- `README.md`

## 4. 빌드 · 실행 · 테스트 명령

모듈 저장소이므로 애플리케이션 빌드·실행 단계가 없다. 변경 검증에는 아래 명령을 사용한다.

| 구분 | 명령 | 비고 |
| --- | --- | --- |
| 문법 검증 | `terraform init -backend=false && terraform validate` | 모듈 저장소이므로 plan 대신 validate로 검증한다. AWS 자격증명 불필요 |
| 예제 plan | `cd example/<이름> && terraform init && terraform plan` | AWS 프로파일과 실제 VPC 등 데이터 소스가 필요하므로 로컬 환경에서만 가능 |
| 정적 분석 | `terraform fmt -check -recursive` | 동작 확인됨(Terraform v1.5.7). 단, 기존 파일 다수가 fmt 미준수 상태이므로 전체 일괄 포맷을 실행하지 않는다. 수정한 파일에만 `terraform fmt <파일>`을 적용한다 |
| 문서 생성 | `terraform-docs markdown .` | README/HELP.md의 Inputs·Outputs 표가 terraform-docs 형식이다. TODO(확인 필요): terraform-docs 실행 옵션과 README 반영 절차 |

`terraform test`용 테스트 파일(`*.tftest.hcl`)은 존재하지 않는다.

## 5. 코드 컨벤션

기존 코드 스타일을 우선 따르고 새로운 스타일을 도입하지 않는다. 언어·문서 공통 규칙은 6장을 따른다. 이 저장소에서 확인된 고유 컨벤션은 다음과 같다.

- 리소스 이름은 자동 계산된다. LB는 `{context.name_prefix}-{lb_name}-{alb|nlb}`(`main.tf`의 `local.name`), 타겟 그룹은 `{context.project}-{name}` 형식이다. 이 네이밍 규칙을 변경하면 기존 사용처의 리소스가 재생성되므로 함부로 수정하지 않는다.
- 입력 변수는 유연성을 위해 `any`/`list(map(string))` 타입과 `lookup(map, key, default)` 패턴을 광범위하게 사용한다. 새 속성을 추가할 때는 필수 키가 아닌 한 `lookup(..., null)`로 기본값을 두어 하위 호환을 유지한다.
- 선택적 블록(access_logs, health_check, stickiness, redirect 등)은 `dynamic` 블록 + `for_each = 조건 ? [] : [값]` 패턴으로 구현한다.
- 리소스 생성 여부는 `count = var.create_lb ? ... : 0` 패턴으로 제어한다. 새 리소스도 동일하게 `create_lb`를 존중해야 한다.
- 태그는 `merge(var.context.tags, <리소스별 공통 태그 변수>, <개별 tags>)` 순서로 병합하고, Name 태그를 마지막에 덮어쓴다.
- 변수 선언에는 `description`을 영문으로 반드시 작성한다. README의 Inputs/Outputs 표는 terraform-docs로 생성되므로 변수 추가·변경 시 README도 함께 갱신한다.
- 이 모듈은 upstream인 terraform-aws-modules/terraform-aws-alb 구조를 따르므로, 새 기능을 추가할 때 upstream의 변수·리소스 명명을 우선 참고한다.
- 이 저장소는 여러 프로젝트가 git source로 참조하는 공유 모듈이다. 기존 변수의 이름·타입·기본값 변경과 리소스 주소 변경(`count` → `for_each` 전환 포함)은 모든 사용처에 파급되는 파괴적 변경이므로, 기능 확장은 추가(additive) 방식으로만 하고 불가피한 경우 영향 범위를 먼저 보고한다.
- 타겟 그룹과 리스너는 리스트 인덱스(`target_group_index`, `https_listener_index`, `http_tcp_listener_index`)로 서로 연결된다. 예제나 문서를 수정할 때 리스트 순서를 바꾸면 연결 대상이 달라지고 리소스가 재생성될 수 있으므로 순서를 유지한다.

## 6. 필수 작업 지침

이 블록은 프로젝트 종류와 무관하게 항상 동일하게 포함된다. 내용을 임의로 수정하거나 축약하지 않는다.

#### 1. 언어 및 문서 규칙

- 소스 코드, 주석, 변수 정의는 영문으로 작성한다.
- 마크다운 문서는 한글로 작성한다.
- 마크다운 문서의 표 형식은 반드시 한 줄을 띄우고 추가한다.

#### 2. 코드 변경 원칙

- 기존 코드를 먼저 읽는다.
- 작업과 명시적으로 관련된 코드 및 파일만 리팩터링한다. 요청 없이 인접한 함수나 파일을 리팩터링하지 않는다.
- 불필요한 리팩터링을 하지 않는다.
- 사용자의 명시적인 확인 없이 새로운 라이브러리, 패키지를 추가하지 않는다.

#### 3. 보안 원칙

- 소스 코드에 크리덴셜 키 유출, 권한 검증 누락, 데이터 노출을 금지한다.

#### 4. 테스트 원칙

- 모듈 단위의 기능 구현을 추가하면 Mock 테스트를 작성하고 통과시킨다.
- 버그를 수정할 때는 먼저 실패하는 회귀 테스트를 작성한 다음, 수정 사항을 구현하여 통과시킨다.
- 단위 또는 통합 테스트에서 실제 네트워크 및 외부 API 호출을 금지한다.

#### 5. 운영 안전 원칙

- REAL(운영) 환경을 대상으로 하는 파괴적 작업을 금지한다.
- 파괴적인 git 명령의 자동 실행을 금지한다. (`git push --force`, `git reset --hard`, `git clean` 등)

## 7. 테스트 정책

현재 자동화된 테스트(`*.tftest.hcl`)와 CI가 없다. 변경 검증은 다음 절차를 따른다.

- 모든 변경 후 `terraform init -backend=false && terraform validate`를 통과시킨다.
- 리스너, 타겟 그룹 등 동작에 영향을 주는 기능을 추가하면 `example/` 하위의 관련 예제를 함께 갱신하거나 새 예제를 추가한다. 예제가 곧 이 모듈의 회귀 테스트 역할을 한다.
- 예제의 `terraform plan`은 실제 AWS 계정의 data source 조회가 필요하므로 로컬에서만 수행하고, 실행 산출물(`.terraform/`, plan 파일, 로그)을 커밋하지 않는다.
- 테스트를 새로 도입하는 경우 Terraform 네이티브 테스트(`*.tftest.hcl`)를 사용하고, 실제 AWS 리소스를 생성하지 않도록 `command = plan` 기반으로 작성한다.

## 8. 보안 정책

- 크리덴셜, 액세스 키, 토큰, 비밀번호를 소스 코드와 문서에 하드코딩하지 않는다.
- 커밋 전에 시크릿 패턴 스캔을 수행한다.

이 저장소의 시크릿 관련 규칙은 다음과 같다.

- AWS 자격증명은 커밋하지 않는다. 예제는 `terraform.tfvars`의 `context.aws_profile`(named profile)로 로컬 AWS CLI 프로파일을 참조하는 방식만 사용한다.
- `example/*/terraform.tfvars`에는 프로파일명·리전·프로젝트명 등 비밀이 아닌 값만 허용한다. 액세스 키, 인증서 개인키, ARN에 포함된 실계정 ID를 새로 추가하지 않는다.
- terraform state 파일(`*.tfstate`)과 `.terraform/` 디렉터리는 커밋하지 않는다.
- HTTPS 리스너 예시 작성 시 `certificate_arn`은 data source 참조 또는 자리표시자만 사용한다.
- 기본 SSL 정책(`listener_ssl_policy_default = "ELBSecurityPolicy-2016-08"`)은 하위 호환을 위해 유지하되, 새로 작성하는 예제와 문서에는 TLS 1.2 이상 정책(예: `ELBSecurityPolicy-TLS-1-2-Ext-2018-06`)을 명시한다.

## 9. Git 작업 규칙

- 커밋 메시지는 Jira 티켓 번호를 접두로 하고, 제목은 한글로 작성한다. 예: `DEVT-5299 access_logs 구성 관련 예시 추가`
- 작업은 `main` 브랜치에서 이루어진다. 별도 브랜치 전략이 확인되지 않았다.

금지되는 git 동작은 다음과 같다.

- `git push --force`, `git reset --hard`, `git clean` 등 파괴적 명령의 자동 실행을 금지한다.
- 사용자가 명시적으로 요청한 경우에만, 영향 범위를 설명한 뒤 실행한다.
- 커밋과 푸시는 사용자의 요청이 있을 때만 수행한다.

## 10. 금지 사항 요약

다음 항목은 예외 없이 금지한다.

| 구분 | 금지 내용 |
| --- | --- |
| 코드 | 크리덴셜 하드코딩, 권한 검증 누락, 데이터 노출 |
| 변경 범위 | 요청 범위 밖 파일·함수 리팩터링, 불필요한 리팩터링 |
| 의존성 | 사용자 확인 없는 라이브러리·패키지 추가 |
| 테스트 | 실제 네트워크·외부 API 호출 |
| 운영 | REAL 환경 대상 파괴적 작업 |
| Git | 파괴적 git 명령의 자동 실행 |
