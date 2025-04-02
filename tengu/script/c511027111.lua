--ドドドウィッチ (Anime)
--Dododo Witch (Anime)
--Script by Rundas
function c511027111.initial_effect(c)
	--cannot normal summon/set
	c:EnableUnsummonable()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511027111(c511027111,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511027111.spcon)
	e1:SetCost(c511027111.spcost)
	e1:SetTarget(c511027111.sptg)
	e1:SetOperation(c511027111.spop)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(c511027111,ACTIVITY_CHAIN,c511027111.chainfilter)
end
function c511027111.chainfilter(re,tp,cc511027111)
	return not ((re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL)) or (re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_TRAP)))
end
function c511027111.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,LOCATION_SZONE,0,1,nil) and Duel.GetCustomActivityCount(c511027111,tp,ACTIVITY_CHAIN)==0
end
function c511027111.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,0)
	e1:SetValue(c511027111.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	aux.RegisterClientHint(e:GetHandler(),nil,tp,1,0,aux.Stringc511027111(c511027111,1),nil)
end
function c511027111.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511027111.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c511027111.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_SPELL) or re:IsActiveType(TYPE_TRAP)
end