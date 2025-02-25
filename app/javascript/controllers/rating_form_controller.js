import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["valueRatingField", "valueRatingDisplay",
        "qualityRatingField", "qualityRatingDisplay",
        "tidinessRatingField", "tidinessRatingDisplay",
        "communicationRatingField", "communicationRatingDisplay",
        "professionalismRatingField", "professionalismRatingDisplay",
        "overallRatingField", "overallRatingDisplay"]

    connect() {
        this.displayRating(this.valueRatingFieldTarget, this.valueRatingDisplayTarget)
        this.displayRating(this.qualityRatingFieldTarget, this.qualityRatingDisplayTarget)
        this.displayRating(this.tidinessRatingFieldTarget, this.tidinessRatingDisplayTarget)
        this.displayRating(this.communicationRatingFieldTarget, this.communicationRatingDisplayTarget)
        this.displayRating(this.professionalismRatingFieldTarget, this.professionalismRatingDisplayTarget)
        this.displayRating(this.overallRatingFieldTarget, this.overallRatingDisplayTarget)
    }

    changeRating(event) {
        const ratingFieldName = (event.target.dataset.ratingFormTarget + "Target");
        const ratingDisplayName = (
            event.target.closest('.form-range-row')
                .querySelector('.rating-display')
                .dataset.ratingFormTarget + "Target");

        const ratingField = this[ratingFieldName];
        const ratingDisplay = this[ratingDisplayName];

        this.displayRating(ratingField, ratingDisplay)
        if (ratingField !== this.overallRatingFieldTarget) {
            this.calculateOverallRating()
        }
    }

    displayRating(ratingField, ratingDisplay) {
        ratingDisplay.textContent = ratingField.value
    }

    calculateOverallRating() {
        const valueRating = parseInt(this.valueRatingFieldTarget.value)
        const qualityRating = parseInt(this.qualityRatingFieldTarget.value)
        const tidinessRating = parseInt(this.tidinessRatingFieldTarget.value)
        const communicationRating = parseInt(this.communicationRatingFieldTarget.value)
        const professionalismRating = parseInt(this.professionalismRatingFieldTarget.value)
        const overallRating = (valueRating + qualityRating + tidinessRating + communicationRating + professionalismRating) / 5
        this.overallRatingFieldTarget.value = overallRating
        this.overallRatingDisplayTarget.textContent = overallRating
    }
}
