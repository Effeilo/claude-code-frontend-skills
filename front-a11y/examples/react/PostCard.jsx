import { Link } from 'react-router-dom';

export default function PostCard({ post, onBookmark, onFilter }) {
    return (
        <article className="post-card">

            <Link to={`/blog/${post.slug}`}>
                <img src={post.thumbnail} />
            </Link>

            <div className="post-card__body">

                <div className="post-card__tags">
                    {post.tags.map(tag => (
                        <span
                            key={tag.id}
                            className={`tag${tag.featured ? ' tag--featured' : ''}`}
                            onClick={() => onFilter(tag)}
                        >
                            {tag.label}
                        </span>
                    ))}
                </div>

                <h3>{post.title}</h3>

                <p>{post.excerpt}</p>

                <div className="post-card__actions">
                    <Link to={`/blog/${post.slug}`}>Read more</Link>
                    <button onClick={() => onBookmark(post)}>
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                            <path d="M5 3h14a1 1 0 0 1 1 1v17l-7-3-7 3V4a1 1 0 0 1 1-1z"/>
                        </svg>
                    </button>
                </div>

            </div>

        </article>
    );
}
