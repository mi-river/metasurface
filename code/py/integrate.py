import re

# ================= 配置区 =================
txt_file = 'S21_TE_Am.txt'  # 你的原始TXT数据文件名
csv_file = 'result_navigator.csv'  # 你的参数CSV文件名
output_file = 'output.txt'  # 处理后输出的新文件名


# ==========================================

def main():
    # 1. 解析CSV文件，构建映射字典
    mapping = {}
    with open(csv_file, 'r', encoding='utf-8') as f:
        lines = f.readlines()

        for line in lines[1:]:
            line = line.strip()
            if not line:
                continue

            # 去除最外层的双引号并替换成单引号
            if line.startswith('"') and line.endswith('"'):
                line = line[1:-1]
            clean_line = line.replace('""', '"')

            # 拆分数据
            parts = re.split(r'\t|\s+', clean_line)
            if parts:
                # 【关键修复】去除可能粘连在数字上的双引号，确保 ID 是纯数字
                run_id = parts[0].replace('"', '').strip()

                # 将剩余的部分重新用空格拼接，格式会变成：1 "50" "50"
                # 如果你想保持原样，也可以用 mapping[run_id] = clean_line
                replacement_str = " ".join(parts)
                mapping[run_id] = replacement_str

    print("解析到的参数映射关系:", mapping)

    # 2. 读取原始TXT文本内容
    with open(txt_file, 'r', encoding='utf-8') as f:
        txt_content = f.read()

    # 3. 替换逻辑
    pattern = r"SZmin\(1\),Zmax\(1\) \((\d+)\)/abs,dB"

    def replacer(match):
        run_id = match.group(1)  # 提取到了纯数字，比如 "1"
        if run_id in mapping:
            # 替换为带参数的格式
            return f"SZmin(1),Zmax(1) ({mapping[run_id]})/abs,dB"
        else:
            return match.group(0)

    # 4. 执行替换并保存
    new_content = re.sub(pattern, replacer, txt_content)

    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(new_content)

    print(f"处理成功！结果已保存至 {output_file}")


if __name__ == "__main__":
    main()