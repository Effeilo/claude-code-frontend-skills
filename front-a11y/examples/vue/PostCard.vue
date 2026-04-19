<template>
    <article class="post-card">

        <RouterLink :to="`/blog/${post.slug}`">
            <img :src="post.thumbnail">
        </RouterLink>

        <div class="post-card__body">

            <div class="post-card__tags">
                <span
                    v-for="tag in post.tags"
                    :key="tag.id"
                    class="tag"
                    :class="{ 'tag--featured': tag.featured }"
                    @click="emit('filter', tag)"
                >
                    {{ tag.label }}
                </span>
            </div>

            <h3>{{ post.title }}</h3>

            <p>{{ post.excerpt }}</p>

            <div class="post-card__actions">
                <RouterLink :to="`/blog/${post.slug}`">Read more</RouterLink>
                <button @click="emit('bookmark', post)">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                        <path d="M5 3h14a1 1 0 0 1 1 1v17l-7-3-7 3V4a1 1 0 0 1 1-1z"/>
                    </svg>
                </button>
            </div>

        </div>

    </article>
</template>

<script setup>
const props = defineProps({
    post: {
        type: Object,
        required: true
    }
});

const emit = defineEmits(['bookmark', 'filter']);
</script>
