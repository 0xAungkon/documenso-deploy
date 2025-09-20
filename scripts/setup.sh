if [ ! -f .installed ]; then
    git clone https://github.com/documenso/documenso --depth 1;
    cd documenso;
    cp /config/.env.documenso .env;
    npm install
    npm run build
    npm run prisma:migrate-deploy
    touch /app/.installed
fi

# # Set working directory for Remix app
cd /app/documenso/apps/remix ; npm run start