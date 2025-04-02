--グリーディー・ヴェノム・フュージョン・ドラゴン (Anime)
--Greedy Venom Fusion Dragon (Anime)
function c511009381.initial_effect(c)
	c:EnableReviveLimit()
	--Fusion Materials: 1 "Predaplant" monster + 1 Level 8 or higher DARK monster
	aux.AddFusionProcCode2(c,true,true,aux.FilterBoolFunctionEx(Card.IsSetCard,SET_PREDAPLANT),c511009381.matfilter)
	--If this card is Fusion Summoned, the Fusion Materials used for its Fusion Summon gain an effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(function(e) return e:GetHandler():IsFusionSummoned() end)
	e1:SetOperation(c511009381.effop)
	c:RegisterEffect(e1)
	--Change the ATK of 1 face-up monster on the field to 0 and negate its effects
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511009381(c511009381,0))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511009381.atkdistg)
	e2:SetOperation(c511009381.atkdisop)
	c:RegisterEffect(e2)
	--Destroy as many monsters on the field as possible, then inflict damage to the controllers equal to the combined original ATK on the field of their destroyed monsters
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc511009381(c511009381,1))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetTarget(c511009381.destg)
	e3:SetOperation(c511009381.desop)
	c:RegisterEffect(e3)
end
c511009381.listed_names={51570882} --"Greedy Venom Fusion Dragon"
c511009381.material_setcode={SET_PREDAP,SET_PREDAPLANT}
function c511009381.matfilter(c,fc,sumtype,tp)
	return c:IsLevelAbove(8) and c:IsAttribute(ATTRIBUTE_DARK,fc,sumtype,tp)
end
function c511009381.effopfilter(c,fusc)
	return c:IsLocation(LOCATION_GRAVE) and fusc:IsReasonCard(c) and c:IsReason(REASON_FUSION) and c:IsReason(REASON_MATERIAL)
end
function c511009381.effop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local mg=c:GetMaterial()
	if not mg or #mg==0 then return end
	mg=mg:Filter(aux.NecroValleyFilter(c511009381.effopfilter),nil,c)
	if #mg==0 then return end
	for mc in mg:Iter() do
		--Special Summon 1 "Greedy Venom Fusion Dragon" from your GY
		local e1=Effect.CreateEffect(mc)
		e1:SetDescription(aux.Stringc511009381(c511009381,2))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		e1:SetProperty(EFFECT_FLAG_DELAY)
		e1:SetCode(EVENT_TO_GRAVE)
		e1:SetRange(LOCATION_GRAVE)
		e1:SetCondition(c511009381.spcon)
		e1:SetCost(Cost.SelfBanish)
		e1:SetTarget(c511009381.sptg)
		e1:SetOperation(c511009381.spop)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD)
		mc:RegisterEffect(e1)
	end
end
function c511009381.spconfilter(c,tp)
	return c:IsPreviousCodeOnField(51570882) and c:IsCode(51570882) and c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousLocation(LOCATION_ONFIELD)
		and c:IsPreviousControler(tp) and c:IsControler(tp) and c:IsReason(REASON_DESTROY)
end
function c511009381.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511009381.spconfilter,1,nil,tp)
end
function c511009381.spfilter(c,e,tp)
	return c:IsCode(51570882) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009381.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511009381.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c511009381.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511009381.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		if #g>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
	--The effects of "Greedy Venom Fusion Dragon" cannot be used for the rest of this turn
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringc511009381(c511009381,3))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,1)
	e1:SetValue(function(e,re,tp) return re:GetHandler():IsCode(51570882) end)
	e1:SetReset(RESET_PHASE|PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511009381.atkdisfilter(c)
	return (not c:IsAttack(0) or c:IsNegatableMonster()) and c:IsFaceup()
end
function c511009381.atkdistg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511009381.atkdisfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009381.atkdisfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511009381.atkdisfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,1,tp,0)
end
function c511009381.atkdisop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local c=e:GetHandler()
		--Change its ATK to 0 until the end of this turn
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESETS_STANDARD_PHASE_END)
		tc:RegisterEffect(e1)
		--Negate its effects until the end of this turn
		tc:NegateEffects(c,RESET_PHASE|PHASE_END)
	end
end
function c511009381.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if chk==0 then return #g>0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c511009381.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if #g>0 and Duel.Destroy(g,REASON_EFFECT)>0 then
		local og=Duel.GetOperatedGroup()
		local g1=og:Filter(Card.IsPreviousControler,nil,tp)
		local g2=og:Filter(Card.IsPreviousControler,nil,1-tp)
		local sum1=g1:GetSum(Card.GetPreviousAttackOnField)
		local sum2=g2:GetSum(Card.GetPreviousAttackOnField)
		if sum1==0 and sum2==0 then return end
		Duel.BreakEffect()
		Duel.Damage(tp,sum1,REASON_EFFECT,true)
		Duel.Damage(1-tp,sum2,REASON_EFFECT,true)
		Duel.RDComplete()
	end
end