# sử dụng node image với tag là 14
#dùng lts và alphine để giảm dung lượng image
FROM node:lts-alpine
# tạo server để chạy file tĩnh
RUN npm install -g http-server
#không cần thiết dùng mkdir vì khi chạy docker run nó sẽ tự tạo folder
RUN mkdir /app
#Chuyển đến thư mục gốc của ứng dụng trong container
WORKDIR /app
# copy các dependencies có thể dùng COPY . . để copy tất cả
COPY package*.json ./ 
# dấu * để copy tất cả file bắt đầu bằng package(package-lock.json)
RUN npm install

COPY . .
# COPY yarn.lock ./
# COPY vue.config.js ./
# COPY vite.config.js ./
# COPY index.html ./
# COPY main.js ./
# COPY App.vue ./
# COPY router.js ./
# COPY rollup.config.js ./
# COPY .env ./
# COPY ./src ./
#không đặt folder là src vì bị trùng với foler bên trong docker
# COPY ./public ./
# COPY ./node_modules ./
# cài đặt dependencies
# RUN yarn install
#BUILD
RUN npm run build
# MỞ PORT 
EXPOSE 8080
#KHỞI ĐỘNG PROJECT KHI RUN CONTAINER, cấu hình theo package.json
# CMD [ "yarn", "dev" ]
CMD [ "http-server", "dist" ]
