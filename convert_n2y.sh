#!/bin/bash

input_file=".config"
output_file=".config_updated"

# 判断输入文件是否存在
if [ ! -f "$input_file" ]; then
  echo "输入文件不存在: $input_file"
  exit 1
fi

# 创建或清空输出文件
> "$output_file"

# 遍历输入文件的每一行
while IFS= read -r line; do
  # 检查行中是否包含"VIRTIO"
  if [[ "$line" =~ "VIRTIO" ]]; then
    # 替换等号后面的内容为y
    line="$(echo "$line" | sed 's/\(.*=.*\)=.*/\1=y/')"
  fi
  # 将处理后的行写入输出文件
  echo "$line" >> "$output_file"
done < "$input_file"

# 使用更新后的配置文件替换原始配置文件
mv "$output_file" "$input_file"
