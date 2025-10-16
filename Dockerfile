# Use Node.js 20 LTS as base image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Install pnpm globally
RUN npm install -g pnpm

# Copy package files for dependency installation
COPY package.json pnpm-lock.yaml ./

# Install ALL dependencies (including dev dependencies for build)
RUN pnpm install --frozen-lockfile

# Copy source code
COPY src/ ./src/

# Copy TypeScript configuration
COPY tsconfig.json ./

# Build the application
RUN pnpm build

# Remove dev dependencies after build to reduce image size
RUN pnpm prune --prod

# Create a non-root user for security
RUN addgroup -g 1001 -S nodejs
RUN adduser -S discord-bot -u 1001

# Create data directories for SQLite database with proper permissions
RUN mkdir -p /app/data /app/dist/agents/data && \
    chown -R discord-bot:nodejs /app/data /app/dist/agents/data && \
    chmod -R 755 /app/dist/agents/data

# Switch to non-root user
USER discord-bot

# Expose port (if needed for health checks)
EXPOSE 3000

# Health check to ensure the bot is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD node -e "console.log('Bot is running')" || exit 1

# Start the application
CMD ["node", "dist/index.js"]
