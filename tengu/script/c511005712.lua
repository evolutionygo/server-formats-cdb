--ＥＭラフメイカー (Anime)
--Performapal Laugh Maker (Anime)
--Scripted by GameMaster(GM), fixed and cleaned up by MLD
Duel.EnableUnofficialProc(PROC_STATS_CHANGED)
function c511005712.initial_effect(c)
	--Pendulum Summon procedure
	Pendulum.AddProcedure(c)
	--Make this card gain 1000 ATK for each monster that gains ATK
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(511001762)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511005712.atktg)
	e1:SetOperation(c511005712.atkop)
	c:RegisterEffect(e1)
	--Special Summon 1 monster from your GY
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511005712(c511005712,2))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCondition(c511005712.spcon)
	e2:SetTarget(c511005712.sptg)
	e2:SetOperation(c511005712.spop)
	c:RegisterEffect(e2)
end
function c511005712.atktgfilter(c,sc,tp)
	local val=c:HasFlagEffect(284) and c:GetFlagEffectLabel(284) or 0
	return c:IsFaceup() and (c:IsControler(1-tp) or c==sc) and c:GetAttack()>val
end
function c511005712.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=eg:FilterCount(c511005712.atktgfilter,nil,e:GetHandler(),tp)
	if chk==0 then return ct>0 end
	e:SetLabel(ct)
end
function c511005712.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		--Gains 1000 ATK for each of those monsters until the end of this turn's Battle Phase
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel()*1000)
		e1:SetReset(RESET_EVENT|RESETS_STANDARD_DISABLE|RESET_PHASE|PHASE_BATTLE|PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c511005712.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousAttackOnField()>c:GetBaseAttack()
end
function c511005712.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511005712.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511005712.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511005712.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511005712.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,tp,0)
end
function c511005712.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end