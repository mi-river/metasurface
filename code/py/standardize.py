import re
import pandas as pd

# ================= 配置区 =================
input_txt = 'output.txt'  # 你刚才生成的 txt 文件
output_csv = 'ml_dataset.csv'  # 将用于模型训练的终版 CSV 文件


# ==========================================

def prepare_ml_dataset():
    data_records = []
    current_L = None
    current_W = None

    with open(input_txt, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()

            # 跳过空行和破折号分割线
            if not line or line.startswith('-'):
                continue

            # 1. 检测表头行，提取 L 和 W
            if 'Frequency' in line and 'SZmin' in line:
                # 匹配类似 (1" "50" "50) 的结构
                # group(1)是序号, group(2)是L, group(3)是W
                match = re.search(r'\((\d+)" "(\d+)" "(\d+)\)', line)
                if match:
                    current_L = float(match.group(2))
                    current_W = float(match.group(3))
                continue

            # 2. 读取数据行并与当前的 L, W 组合
            if current_L is not None and current_W is not None:
                # 用空白字符（空格或制表符）分割频率和S参数
                parts = line.split()
                if len(parts) == 2:
                    try:
                        freq = float(parts[0])
                        s_param = float(parts[1])

                        # 保存为一条完整的训练样本
                        data_records.append({
                            'Frequency': freq,
                            'L': current_L,
                            'W': current_W,
                            'S_parameter': s_param
                        })
                    except ValueError:
                        # 忽略无法转换为数字的异常行
                        pass

    # 3. 转换为 DataFrame 并导出为 CSV
    df = pd.DataFrame(data_records)
    df.to_csv(output_csv, index=False)

    print(f"数据清洗完成！共提取 {len(df)} 条训练样本。")
    print(df.head())  # 打印前几行预览


if __name__ == "__main__":
    prepare_ml_dataset()