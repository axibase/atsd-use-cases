# Technical Writing for Software Developers

![](images/axibase-logo.png.png) 

## Introduction

Technical writing is one of the four primary expressions of written language, these forms are known as different things to different people but the general concept is usually the same across languages and nations:

* **Creative / Narrative Writing:** Fictional or non-fictional writing meant to serve an entertaining or informative purpose by telling a story or recounting an event.
* **Pursuasive Writing:** Fictional or non-fictional writing meant to convince the reader of an opinion, or at least consider a viewpoint.
* **Academic / Scientific Writing:** Non-fictional writing meant to define and defend a thesis / hypothesis for the intellectual community.
* **Technical / Expository Writing:** Non-fictional writing meant to explain a process or product, the advantages therein, and its usage for an unfamiliar audience.

Technical writing comes in many different flavors for many different fields, each has their own idosyncracies and norms. Even though software development is one of the most widely-known and frequently talked-about fields in the modern age, it remains one of the least-understood on a technical level. When writing for others, especially end users and non-technical personnel, it's important to communicate effectively and concisely so that the meaning of the writing isn't drowned out by white noise or excessive verbosity. 

### Key Parameters

The easiest way to assess and analyze meaningful technical writing is to use quantifiable metrics which may be judged impartially. These parameters are broad enough that they may be applied to any piece of technical writing, but specific enough as to be informative and useful. 

Just remember your ABCs: 

* **Accuracy:** Although seemingly obvious, an astoundning amount of technical writing contains factural errors, careless mistakes, or otherwise thoughtless omittions that discourage users from advancing their understanding of a product or pursuing its implementation in their working environment. Unused software is no software at all.

* **Brevity:** When attempting to use a new feature or sample a new product, no audience has unlimited time. Make sure that technical writing is produced with the understanding that readers have places to be and people to see. Make a point before losing their attention.

* **Clarity:** The average reader will spend roughly one percent of the amount of time working with the final product that you spend developing it, probably less. The minutae and subtle features of the product or process may largely escape them. Acknowledge this fact and adjust technical pieces to respect it. 

> [GitHub Issue: Terrible Documentation](https://github.com/search?q=terrible+documentation&type=Issues)

![](images/rails-img.png)

## Schools of Thought: Classicism versus Modernism

Like software development itself, technical writing has evolved throughout its existence. Although the descerning reader may point to many subcategories within the two most general: classical and modern, osctensibly each new iteration of technical writing practice is either a continuation of what was, or an attempt at something new.

Classical technical writing tends to use more formal language, and constructions that are rarely spoken:

* "The container *in which* the new instance was launched *shall* begin logging information immediately."

Modern technical writing tends to resemble the spoken dialect more closely:

* "The container *where* the new instance was launched *will* begin logging information immediately."

Like with almost everything else, good technical writing will find the balance between these two schools of thought: 

* "The container *in which* the new instance was launched *will* begin logging information immediately."

### In Practice

When applied to real-world scenarios, a balanced technical writing style is often apparent to any reader regardless of their technical knowledge. Try to read a technical piece from the position of someone who has inferior and superior knowledge to the theme as they will most likely be reading the document before publication as a member of your team, and after publication as a member of the general public.

Delegating technical writing to one person is dangerous. A person with a general understanding of many parts of a system but lacking a thorough knowledge of any one part will never be able to produce the level of user required to make any software a truly global solution. Cooperatively-generated technical documentation and instruction means an in-depth result that provides the answers to questions a reader didn't even know they had.

Picture the operating instructions for the most widely-used or popular programmatic solutions in the world, chances are their operation is supported by technical documentation that is easy to interact with.

### In Style

The presentation of writing is nearly as important as the writing itself. A great document published with an oppressive design forces readers to pre-suppose an overly-complex and esoteric document which may discourage a thorough reading of the piece. A technical document of any length should be well-indexed and annotated but presenting a first-time reader with a multi-paged list of every feature available to end users will often serve only to frustrate. Don't let a well-written piece go un-read because it looks like a legal document. 

*Empowering Presentation*

![](images/good-tech.png)

> Links, formatting, and visibility are all features of cohesive technical writing.

*Oppressive Presentation*

![](images/bad-tech.png)

> A lack of organization or obvious inability to easily navigate throughout documentation destroys the primary advantage of online documentation. 

## The Global Audience and International Writer

Write technical documentation with the world in mind. Whether this means simplifying the launguage in a technical document or using industry-standard terminology, be sure that the writing may be read by anyone with access to a translator, or a basic understanding of the language of the document. In the field of software development and computer science, the common and widely-understood lexicon should be used to properly name and describe operations and features. See the [Resources](#resources) section of this document for helpful links regarding composition.

**Literary Language:** Avoid the desire to use words based on length or complexity. Words should be choosen for their ability to properly convey the required information.

* "Leveraging programmatic solutions to common problems in the legacy API should be considered before seeking a new solution entirely."

* "Leveraging programmatic resolutions to prosaic botherations in the legacy API must be pondered before combing for a new elucidation entirely."

**Thesaurus Syndrome:** Avoid overuse of the thesaurus. Demonstrating a well-ranged vocabulary is important, but conveying clear information is even more important. Don't be afraid of using the same word several times if it applies to several situations. Common words are the place to use the thesaurus. Using too many variations of a word can easily create a confusing sentence that neither proposes a solution nor offers an explanation. 

*Good Thesaurus Usage*

* "After the user has done the installation process, they need to do the set-up procedure, then do the operation."

* "After the user has executed the installation process, they need to perform the set-up procedure, then complete the operation."

*Bad Thesaurus Usage*

* "A device operating on a secure network is able to easily connect with other devices using the network as well. Network traffic among devices may be monitored and throttled using IPv6 protocol."

* "A device oprating on a secture network is able to easily connect with other equipment using the structure as well. System traffic among apparatus may be monitored and throttled using IPv6 protocol."

## Technical Points

No technical writing guide would be complete without a technical explanation of the finer points of writing accurately, briefly, and clearly. The inarguable features of writing of any kind are explored here.

**Grammar:** One of the most important parts of any written document is the attention to grammar and punctuation. A misplaced comma or improperly emphasized clause is able to change the entire meaning of the sentence.

* "One lunch per student. No student may have two lunches."

* "One lunch per student? No! Student may have two lunches." 

**The Third Person:** When writing technical documents, it's usually best to avoid personal pronouns such as I, you, and we unless it is explicitly required. Often this means restructuring sentences to use different registers or tenses.

* "We have been been developing the rule engine since 2004."

* "The rule engine has been in development since 2004."

**Contractions:** Using contractions is part of the choice between classicism and modernism. Classical knowledge is that the use of contractions should be avoided in any technical document whereas modern documents often feature at least a few. Use common sense or refer to other technical documents when faced with a difficult decision.

* "Let's move on to the next topic, it'll have several components, they're not difficult to explain."

* "Let us move on to the next topic, it will have several components, they are not difficult to explain."

**The Passive Voice:** It is generally recommended to avoid the passive voice in technical writing other than using it to soften the accusitory tone of a particular expression. Some situations require the passive voice, in which case, its use is perfectly acceptable for example to include the mention of an activty or process in which the reader has no part.

*Accusation*

* "If launch fails to initiate, the *user did not* complete the installation process correctly."

* "If launch fails to initate, the *installation was not* completed correctly."

*Non-Participation*

* " *SQL Console is used* to query data stored in ATSD using a convenient syntax."

* " *A user uses* SQL Console to query data stored in ATSD using a convenient syntax."

**Articles:** More often than traditional English writing, some articles may be omitted in places they would otherwise register as required. This is especially true of short, imperitive sentences. Both examples below are correct, but because ATSD is a well-known product, and the sentence is written in the imperative, omitting the article sounds more professional.

* "Launch *the* Axibase Time Series Database using the following command:

```sh
sudo apt-get update && sudo apt-get install atsd
```

* Launch Axibase Time Series Database using the following command:

```sh
sudo apt-get update && sudo apt-get install atsd
```

> It's worth noting here, that "the following [anything]" must always include the definite article.

**The Oxford Comma:** Either use it, or don't use it. You can't do both.

* "Technical writing is about accuracy, brevity, and clarity."
* "Technical writing is about accuracy, brevity and clarity."

## Corporate Blogging

Many large corporations operate a blog or journal of their activities. Sometimes this is one publication, as is the case with the [IBM Analytics Community](https://www.ibm.com/communities/analytics/cognos-analytics/blog/) or [Redmine Blog](http://www.redmineblog.com/), who document software updates and changes in the same place as use cases and research articles. 

*Strenghs of the Unified Resource*

* Ease-of-Access

* Crossover Appeal

* Integrated Advertising

Other corporations seperate the two publications, as with the [Apple Newsroom](https://www.apple.com/newsroom/) and [Apple Support](https://support.apple.com/en-us/HT208067)

*Strengths of Separate Resources*

* Ease-of-Navigation

* Specific Audience

* Lack of Advertising

*Additional Corporate Blogs for Consideration*

* [Kali Linux Blog](https://www.kali.org/blog/)

* [Microsoft Windows Blog](https://blogs.windows.com/)

* [Oracle Blog](https://blogs.oracle.com/) and [Oracle Developer's Blog](https://blogs.oracle.com/developers/)

### Targeted Outcomes

Hosting a corporate blog has the ability to waste a lot of time, or accomplish a lot of things. When writng analytic documents such as use cases or solution briefs, remember your purpose:

* **Make Your Time Count**: Writing can create huge outlays when performed improperly and disorganized. Make sure your writing is efficient, effective, and engaging. Compose pieces which generate interest, inspire conversation, and create oppurtunity.

* **Represent Your Product:** An article that touches on a hot-button issue or topical theme is only as good a blog post as it is able to relate to the underlying software. Inspiring thught in a reader's cognitive space is no use if it doesn't demonstrate the way the technology facilitated that discovery. 

* **Engage Your Audience:** At the other extreme, a densely-worded write-up on the paticularities of the latest version of some tool doesn't accomplish the task of engagement. Readers should come to your space to see a tool or service in action. Link to the technical writing if the oppurtunity presents itself, but don't force it on unwitting civilians. 

## Resources

**Purdue OWL:** The [Online Writing Lab](https://owl.english.purdue.edu/owl/section/4/16/) from Purdue Uninversity is a valuable resource for writers of all kinds. It features specific templates for every variety of technical writing, so that any piece is able to meet post-university level publication standards.

**Duke University ESL / EFL Resources:** The Thompson Writing Program publishes a [public catalog](https://twp.duke.edu/twp-writing-studio/resources-students/esl) of technical writing resources for non-native speakers of English.

**Harvard Business Review:** An online [publication](https://hbr.org/) which releases articles on everything from employee management to technical writing strategy.

**Society for Technical Communication:** [Technical Communication Online](https://www.stc.org/techcomm/) is a quarterly industry journal written by professional technical writers and speakers which publishes several free articles with each edition.
