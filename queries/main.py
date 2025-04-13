import requests
import json
import os

url = "http://localhost:8080/api/graphql"

headers = {
    "Content-Type": "application/json",
    # "Authorization": "Bearer <your-token>",  # 필요 시 주석 해제
}

query = """
mutation createQuery($input: CreateQueryInput!) {
  createQuery(input: $input) {
    urn
  }
}
"""


# variables 부분을 외부 파일에서 읽어옴
def load_queries_from_file(file_path):
    with open(file_path, "r", encoding="utf-8") as f:
        return json.load(f)


# 각 쿼리를 실행하는 함수
def create_query(variables):
    response = requests.post(
        url,
        headers=headers,
        json={"query": query, "variables": variables, "operationName": "createQuery"},
    )
    return response


# 쿼리 데이터 파일 경로
queries_file = "./query_data.json"

# 파일에서 쿼리 목록 로드
queries_data = load_queries_from_file(queries_file)

# 각 쿼리에 대해 API 요청 실행
for idx, query_data in enumerate(queries_data):
    print(f"쿼리 {idx+1} 생성 중...")
    res = create_query({"input": query_data})
    print(f"상태 코드: {res.status_code}")
    print(f"응답: {res.json()}")
    print("-" * 50)
