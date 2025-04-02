--天融星カイキ (Anime)
--Kaiki the Unity Star (Anime)
Duel.EnableUnofficialProc(PROC_STATS_CHANGED)
function c511009110.initial_effect(c)
	--Fusion Summon
	local params = {nil,Fusion.IsMonsterFilter,nil,nil,nil,c511009110.stage2}
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511009110(c511009110,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,c511009110)
	e1:SetCost(c511009110.fuscost)
	e1:SetTarget(Fusion.SummonEffTG(table.unpack(params)))
	e1:SetOperation(Fusion.SummonEffOP(table.unpack(params)))
	c:RegisterEffect(e1)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCode(c511009110)
	e3:SetCondition(c511009110.spcon)
	e3:SetOperation(c511009110.spop)
	c:RegisterEffect(e3)
end
function c511009110.fuscost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,500) end
	Duel.PayLPCost(tp,500)
end
function c511009110.stage2(e,tc,tp,sg,chk)
	if chk==1 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetCountLimit(1)
		e1:SetCondition(c511009110.damcon)
		e1:SetOperation(c511009110.damop)
		e1:SetReset(RESET_EVENT|0x3fe0000)
		tc:RegisterEffect(e1)
	end
end
function c511009110.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511009110.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,c511009110)
	Duel.Damage(tp,500,REASON_EFFECT)
end
function c511009110.cfilter(c,tp)
	local val=0
	if c:GetFlagEffect(284)>0 then val=c:GetFlagEffectLabel(284) end
	return c:IsType(TYPE_FUSION) and c:IsControler(tp) and c:GetAttack()~=val
end
function c511009110.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local eff={c:GetCardEffect(EFFECT_NECRO_VALLEY)}
	for _,te in ipairs(eff) do
		local op=te:GetOperation()
		if not op or op(e,c) then return false end
	end
	return eg:IsExists(c511009110.cfilter,1,nil,tp)
end
function c511009110.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.SelectEffectYesNo(tp,c) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end