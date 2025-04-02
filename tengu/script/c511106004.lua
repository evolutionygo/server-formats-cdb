--ダイナレスラー・カポエラプトル
--Dinowrestler Capoeiraptor (Anime)
--scripted by Hatter
function c511106004.initial_effect(c)
	--Destruction replacement
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(function(e) return e:GetHandler():IsAttackPos() end)
	e1:SetTarget(c511106004.reptg)
	c:RegisterEffect(e1)
	--Change itself to Defense position
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetCondition(c511106004.poscon)
	e2:SetOperation(c511106004.posop)
	c:RegisterEffect(e2)
	--Special summon 1 "Dinowrestler Capoeiraptor" from the Deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc511106004(c511106004,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,c511106004)
	e3:SetCondition(c511106004.spcon)
	e3:SetTarget(c511106004.sptg)
	e3:SetOperation(c511106004.spop)
	c:RegisterEffect(e3)
end
c511106004.listed_names={29996433}
function c511106004.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReason(REASON_BATTLE) end
	e:GetHandler():RegisterFlagEffect(c511106004,RESET_EVENT+RESETS_STANDARD,0,1)
	return true
end
function c511106004.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsRelateToBattle() and e:GetHandler():GetFlagEffect(c511106004)~=0
end
function c511106004.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsAttackPos() then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
		e:GetHandler():ResetFlagEffect(c511106004)
	end
end
function c511106004.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsDefensePos() and Duel.IsTurnPlayer(tp)
end
function c511106004.spfilter(c,e,tp)
	return c:IsCode(29996433) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511106004.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511106004.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511106004.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511106004.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end