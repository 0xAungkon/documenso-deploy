# Use Node 20 on Debian Bookworm
FROM node:20.19-bookworm

# Set working directory
WORKDIR /init

# Install git for cloning
RUN apt-get update && apt-get install -y \
    libcairo2-dev \
    libjpeg-dev \
    libpango1.0-dev \
    libgif-dev \
    librsvg2-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

COPY ./scripts/setup.sh setup.sh
RUN chmod +x setup.sh

WORKDIR /app
# # Install dependencies
# RUN npm install

# # Build the project
# RUN npm run build

# # Run Prisma migrations
# RUN npm run prisma:migrate-deploy

# # Set working directory for Remix app
# WORKDIR /app/apps/remix

# # Expose port for the Remix server
# EXPOSE 3000

# Start Remix
# CMD ["npm", "run", "start"]
CMD  bash /init/setup.sh > /app/setup.log 2>&1
# CMD ["tail", "-f", "/dev/null"]
