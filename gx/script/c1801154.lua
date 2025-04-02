--遠心分離フィールド
--Centrifugal Field
function c1801154.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc1801154(c1801154,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_EVENT_PLAYER)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCode(EVENT_CUSTOM+c1801154)
	e2:SetTarget(c1801154.sptg)
	e2:SetOperation(c1801154.spop)
	c:RegisterEffect(e2)
	aux.GlobalCheck(s,function()
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_TO_GRAVE)
		ge1:SetOperation(c1801154.check)
		Duel.RegisterEffect(ge1,0)
	end)
end
function c1801154.check(e,tp,eg,ep,ev,re,r,rp)
	for tc in aux.Next(eg) do
		if tc:IsType(TYPE_FUSION) and tc:IsReason(REASON_DESTROY) and tc:IsReason(REASON_EFFECT) then
			Duel.RaiseEvent(tc,EVENT_CUSTOM+c1801154,re,r,rp,tc:GetOwner(),ev)
		end
	end
end
function c1801154.spfilter(c,e,tp,fc)
	return fc:ListsCodeAsMaterial(c:GetCode()) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c1801154.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local fc=eg:GetFirst()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c1801154.spfilter(chkc,e,tp,fc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c1801154.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,fc) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c1801154.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,fc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c1801154.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end