# tesstrain-xsa

Finetune Training and OCR evaluation of Tesseract 5.0.0 Alpha for Sabaean language in Ancient South Arabian script using
 [tesstrain Training workflow for Tesseract 4 as a Makefile](https://github.com/tesseract-ocr/tesstrain). Certain file locations and scripts have been modified compared to source repos.

OCR evaluation is done using [ISRI Analytic Tools for OCR Evaluation with UTF-8 support](https://github.com/eddieantonio/ocreval) and  and [The ocrevalUAtion tool](https://sites.google.com/site/textdigitisation/ocrevaluation).

## Sabaean language in Ancient South Arabian script

Replace the top layer training was done using two fonts. The sample training text was scraped via google search.

### Training Steps

* Make [training text](langdata/xsa.txt)
* List [available fonts that can render the training text](langdata/xsa.fontslist.txt)
* Update fonts directory unicodefontdir in [txt2lstmf.sh](txt2lstmf.sh)
* Run [txt2lstmf.sh](txt2lstmf.sh) to create the images, ground truth and lstmf files in [gt/xsa](gt/xsa)
* Run [trainlayer.sh](trainlayer.sh) to download the starting ara.traineddata and other files and start the training via makefile
* Run [checkpointeval.sh](checkpointeval.sh) to evaluate the accuracy of different checkpoints.
* Resulting traineddata file, which can be used as starting model for further training, is at [best_xsa1. traineddata](best_xsa1. traineddata).

### Evaluation Results

See [reports](reports/checkpointeval.txt). 

Best accuracy for both fonts at xsaLayer_0.869_2978_7700 is the following:

Quivira -    83.30%  Accuracy

Segoe_UI_Historic -    81.60%  Accuracy

