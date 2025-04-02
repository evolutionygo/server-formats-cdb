--アルカナフォースⅦ－THE CHARIOT (Anime)
--Arcana Force VII - The Chariot (Anime)
function c511016000.initial_effect(c)
	--coin
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511016000(34568403,0))
	e1:SetCategory(CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c511016000.cointg)
	e1:SetOperation(c511016000.coinop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
c511016000.toss_coin=true
function c511016000.cointg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c511016000.coinop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	c511016000.arcanareg(c,Arcana.TossCoin(c,tp))
end
function c511016000.arcanareg(c,coin)
	--coin effect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc511016000(34568403,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511016000.spcon)
	e1:SetTarget(c511016000.sptg)
	e1:SetOperation(c511016000.spop)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c511016000.ctop)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetOperation(c511016000.regop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_CUSTOM+c511016000)
	e4:SetTarget(c511016000.spctg)
	e4:SetOperation(c511016000.spcop)
	c:RegisterEffect(e4)
	e3:SetLabelObject(e4)
	Arcana.RegisterCoinResult(c,coin)
	c:RegisterFlagEffect(51116000,0,0,1,coin)
end
function c511016000.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Arcana.GetCoinResult(e:GetHandler())==COIN_HEADS
end
function c511016000.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and not tc:IsLocation(LOCATION_MZONE)
		and tc:IsPreviousControler(1-tp) and tc:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,tc,1,0,0)
end
function c511016000.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511016000.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--heads
	if Arcana.GetCoinResult(c)==COIN_HEADS and c:GetFlagEffectLabel(51116000)==COIN_HEADS then
		c:SetFlagEffectLabel(51116000,COIN_TAILS)
	end
	--tails
	if Arcana.GetCoinResult(c)==COIN_TAILS and c:GetFlagEffectLabel(51116000)==COIN_TAILS then
		c:SetFlagEffectLabel(51116000,COIN_HEADS)
	end
end
function c511016000.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffectLabel(51116000)==COIN_HEADS and e:GetLabelObject():IsActivatable(tp) then
		Duel.RaiseSingleEvent(c,EVENT_CUSTOM+c511016000,e,r,rp,tp,0)
	else
		e:GetLabelObject():Reset()
	end
	c:ResetFlagEffect(51116000)
	e:Reset()
end
function c511016000.spctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:Reset()
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511016000.spcop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,c:GetPreviousControler(),1-c:GetPreviousControler(),false,false,POS_FACEUP)
	end
end